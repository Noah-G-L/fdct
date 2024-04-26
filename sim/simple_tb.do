# simple_tb.do 
# created by Noah Limpert, nlimpert@hmc.edu, Apr 21 2024
# .do files inspired by OpenHW CVW Project
# purpose, run tb file in questa modelsim

# to run it
# at the "ModelSim>" prompt:
#     do simple_tb.do
#  to run from a shell, type the following at the shell prompt:
#     vsim -do simple_tb.do -c
# (omit the "-c" to see the GUI while running from the shell) <-- instruction taken from wally

#not sure what this does
onbreak {resume} 
  
set ROOT_PATH "/home/nlimpert/FDCT_VLSI"
set DUT "adder"
set TESTBENCH "vector_testbench"
set TESTVECTOR "adder_tv"
set WKDIR ${ROOT_PATH}/wkdir/${DUT}_${TESTBENCH}

set SRC ${ROOT_PATH}/src
set TB ${ROOT_PATH}/testbench
set TV ${ROOT_PATH}/tests

# create library
if [file exists ${WKDIR}] {
    vdel -lib ${WKDIR} -all
}

vlib ${WKDIR} +incdir+${TV} 

# compile source 

vlog  -work ${WKDIR} ${TV}/${TESTVECTOR}.txt
vlog -lint -work ${WKDIR} +incdir+${SRC} +incdir+${TV} +incdir+${TB} ${SRC}/${DUT}.sv ${SRC}/*.sv 

vsim -lib ${WKDIR} -do "run -all" ${TESTBENCH}

quit