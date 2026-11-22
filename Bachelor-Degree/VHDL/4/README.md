# Barrel Shifter Implementations in VHDL

**This repository contains two VHDL implementations of a Barrel Shifter, each with different features.**

## 1. Barrel_Shifter (Basic Version)
### This is a simple barrel shifter that performs fixed shifting based on the `shift` input.

### Features:
#### Inputs:
- `data_in (5 downto 0):` The input data to be shifted.
- `load (5 downto 0):` The load value used for shifting.
- `shift (2 downto 0):` Determines how many positions the data should be shifted.
- `Clock:` The clock signal to synchronize shifting.
#### Output:
  - `data_o (5 downto 0):` The shifted output.

### Functionality:
- When `shift` is set, the data is shifted left by a specific number of positions.
- The `load` input is used to insert values at the lower bits after shifting.
- This version only shifts the existing data without adding new external values.

---

## 2. Barrel_Shifter (Version with Serial Input)
### This version improves the previous one by allowing serial input data to be inserted while shifting.

### Features:
#### Inputs:
- `data_in (5 downto 0):` The initial input data.
- `serial_in (5 downto 0):` Serial input data that can be inserted during shifting.
- `load:` A control signal to load data_in initially.
- `shift (2 downto 0):` Determines how many positions the data should be shifted.
- `Clock:` The clock signal for synchronization.
#### Output:
- `data_out (5 downto 0):` The final shifted output.

### Functionality:
- If `load` is `1`, `data_in` is loaded into the register.
- When `shift` is activated, the existing data is shifted left, and new bits from `serial_in` are inserted at the lower positions.
- This version is more flexible because it allows dynamic data insertion during shifting.
