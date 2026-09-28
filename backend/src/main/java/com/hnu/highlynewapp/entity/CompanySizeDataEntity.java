package com.hnu.highlynewapp.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Data
@AllArgsConstructor
public class CompanySizeDataEntity implements Serializable {

    String name;

    Integer value;
}
