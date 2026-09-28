#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
边界阈值测试脚本：找到 SteganoGAN decode 成功的最小图片尺寸
"""
import os
import time
from PIL import Image

# 加载模型（耗时约2-3分钟）
print("[TEST] 正在加载 SteganoGAN 模型...")
from steganogan import SteganoGAN
model = SteganoGAN.load(architecture='dense', cuda=False)
print("[TEST] 模型加载完成，开始测试\n")

BASE_DIR = '/home/master/ImgStegano/cache'
INPUT_PATH = os.path.join(BASE_DIR, 'input_pictures', 'origion_img.jpg')
TEST_DIR = os.path.join(BASE_DIR, 'threshold_test')
os.makedirs(TEST_DIR, exist_ok=True)

# 打开原图
orig = Image.open(INPUT_PATH)
w0, h0 = orig.size
orig_pixels = w0 * h0

# 测试尺寸列表：从大到小，快速定位范围
test_scales = [
    1.0,    # 100% - 已知成功
    0.8,    # 80%
    0.6,    # 60%
    0.5,    # 50%
    0.4,    # 40%
    0.35,   # 35%
    0.3,    # 30%
    0.25,   # 25%
    0.2,    # 20% - small_img 约在此范围
    0.15,   # 15%
    0.1,    # 10%
]

results = []

for scale in test_scales:
    w = int(w0 * scale)
    h = int(h0 * scale)
    pixels = w * h
    
    # 生成测试图
    test_img = orig.resize((w, h), Image.LANCZOS)
    test_path = os.path.join(TEST_DIR, f'test_{w}x{h}.png')
    encoded_path = os.path.join(TEST_DIR, f'encoded_{w}x{h}.png')
    test_img.save(test_path)
    
    msg = f"THRESHOLD_TEST_{w}x{h}"
    
    print(f"[{scale*100:5.1f}%] {w}x{h} ({pixels:,} px) -> ", end='', flush=True)
    
    try:
        # Encode
        t0 = time.time()
        model.encode(test_path, encoded_path, msg)
        t_enc = time.time() - t0
        
        # Decode
        t0 = time.time()
        decoded = model.decode(encoded_path)
        t_dec = time.time() - t0
        
        success = (decoded == msg)
        status = "SUCCESS" if success else f"WRONG_MSG(got:{decoded})"
        
        print(f"{status} | enc:{t_enc:.1f}s dec:{t_dec:.1f}s")
        results.append({
            'scale': scale, 'w': w, 'h': h, 'pixels': pixels,
            'success': success, 'msg': msg, 'decoded': decoded,
            't_enc': t_enc, 't_dec': t_dec
        })
        
    except Exception as e:
        print(f"FAILED | {str(e)[:60]}")
        results.append({
            'scale': scale, 'w': w, 'h': h, 'pixels': pixels,
            'success': False, 'msg': msg, 'decoded': str(e),
            't_enc': 0, 't_dec': 0
        })

# 输出汇总
print("\n" + "="*70)
print("边界阈值测试汇总")
print("="*70)

# 找到最后一个成功的和第一个失败的
last_success = None
first_fail = None
for r in results:
    if r['success'] and not first_fail:
        last_success = r
    elif not r['success'] and last_success and not first_fail:
        first_fail = r

if last_success:
    print(f"最大成功尺寸: {last_success['w']}x{last_success['h']} ({last_success['pixels']:,} px)")
if first_fail:
    print(f"最小失败尺寸: {first_fail['w']}x{first_fail['h']} ({first_fail['pixels']:,} px)")

print("\n详细结果:")
for r in results:
    icon = "SUCCESS" if r['success'] else "FAILED "
    print(f"[{icon}] {r['w']:4d}x{r['h']:4d} ({r['pixels']:>10,} px) scale={r['scale']:.2f} -> {r['decoded'][:50]}")

# 如果有需要精细搜索的范围，自动进行
if last_success and first_fail:
    print("\n" + "="*70)
    print("精细搜索阶段")
    print("="*70)
    
    # 在 last_success 和 first_fail 之间插入更多测试点
    fine_scales = []
    s1, s2 = last_success['scale'], first_fail['scale']
    for i in range(1, 10):
        s = s1 + (s2 - s1) * i / 10
        fine_scales.append(s)
    
    fine_results = []
    for scale in fine_scales:
        w = int(w0 * scale)
        h = int(h0 * scale)
        pixels = w * h
        
        # 跳过重复尺寸
        if any(r['w'] == w and r['h'] == h for r in results):
            continue
            
        test_img = orig.resize((w, h), Image.LANCZOS)
        test_path = os.path.join(TEST_DIR, f'test_{w}x{h}.png')
        encoded_path = os.path.join(TEST_DIR, f'encoded_{w}x{h}.png')
        test_img.save(test_path)
        
        msg = f"THRESHOLD_TEST_{w}x{h}"
        
        print(f"[{scale*100:5.1f}%] {w}x{h} ({pixels:,} px) -> ", end='', flush=True)
        
        try:
            t0 = time.time()
            model.encode(test_path, encoded_path, msg)
            t_enc = time.time() - t0
            
            t0 = time.time()
            decoded = model.decode(encoded_path)
            t_dec = time.time() - t0
            
            success = (decoded == msg)
            status = "SUCCESS" if success else f"WRONG_MSG"
            print(f"{status} | enc:{t_enc:.1f}s dec:{t_dec:.1f}s")
            fine_results.append({'scale': scale, 'w': w, 'h': h, 'pixels': pixels, 'success': success})
        except Exception as e:
            print(f"FAILED | {str(e)[:60]}")
            fine_results.append({'scale': scale, 'w': w, 'h': h, 'pixels': pixels, 'success': False})
    
    # 合并结果并重新找边界
    all_results = results + fine_results
    all_results.sort(key=lambda x: x['pixels'], reverse=True)
    
    last_success2 = None
    first_fail2 = None
    for r in all_results:
        if r['success'] and not first_fail2:
            last_success2 = r
        elif not r['success'] and last_success2 and not first_fail2:
            first_fail2 = r
    
    if last_success2:
        print(f"\n最终边界：")
        print(f"  SUCCESS: {last_success2['w']}x{last_success2['h']} ({last_success2['pixels']:,} px)")
    if first_fail2:
        print(f"  FAILED:  {first_fail2['w']}x{first_fail2['h']} ({first_fail2['pixels']:,} px)")

print("\n[TEST] 测试完成")
