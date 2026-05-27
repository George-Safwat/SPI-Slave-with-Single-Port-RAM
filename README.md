# SPI Slave Interface — Verilog Implementation

## A Verilog-based SPI Slave design implementing:

Write operation
Read address phase
Read data phase
FSM-controlled SPI protocol handling

The project is designed for RTL simulation and digital design practice.

### Features:
SPI slave communication
FSM-based controller

### Supports:
WRITE command
READ ADDRESS command
READ DATA command
Serial-to-parallel data reception
Parallel-to-serial data transmission
Active-low reset
Synthesizable RTL

### Project Structure:
├── spi.v              # SPI slave RTL
├── spi_wrapper.v      # Top-level wrapper
├── spi_tb.v           # Testbench
├── Makefile           # Simulation automation
└── README.md
SPI FSM States

### The design uses a finite state machine (FSM) with the following states:

#### State	Description:
IDLE	Waiting for slave select
CHK_CMD	Decodes SPI command
WRITE	Receives write data
READ_ADD	Receives read address
READ_DATA	Sends read data on MISO

#### State encoding:

parameter IDLE      = 3'b000;
parameter CHK_CMD  = 3'b001;
parameter READ_ADD = 3'b010;
parameter READ_DATA= 3'b011;
parameter WRITE    = 3'b100;
