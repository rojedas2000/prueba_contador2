# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles
from cocotb.result import TestFailure

clk_period = 100 

@cocotb.test()

async def test_counter_reset(dut):
    dut._log.info("Iniciando testb del reset")
    #configurando relog 
    clock = Clock(dut.clk, clk_period, unit="ns")
    cocotb.start_soon(clock.start())
    #reset activo en bajo
    dut.rst_n.value=0
    await ClockCycles(dut.clk, 2)
    #liberar el rst
    dut.rst_n.value=1
    await ClockCycles(dut.clk, 1)

    #poniendo assertion
    if dut.c.value.integer !=0:
        raise TestFailure(f"el contador no se reseteo. valor={dut.c.value}")
    else 
        dut._log.info("si jalo")

async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    dut.ui_in.value = 20
    dut.uio_in.value = 30

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 1)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
