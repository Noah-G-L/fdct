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
set DUT "rotation"
set TESTBENCH "param_mult_vector_testbench"
set TESTVECTOR "rotation_tv"
set WKDIR ${ROOT_PATH}/wkdir/${TESTBENCH}

set SRC ${ROOT_PATH}/src
set TB ${ROOT_PATH}/testbench
set TV ${ROOT_PATH}/tests

# create project directory and open it  // for some reason, I cannot reuse 
project new ${WKDIR} ${DUT}

project env 

project open ${WKDIR}/${DUT}.mpf

project env 

# Add source files to project
project addfile  ${SRC}/adder.sv
#project addfile  ${SRC}/fdct.sv
project addfile  ${SRC}/flopr.sv
project addfile  ${SRC}/negative.sv
project addfile  ${SRC}/param_mult.sv
project addfile  ${SRC}/rotation.sv
project addfile  ${SRC}/sub.sv
project addfile  ${SRC}/truncate.sv

# Add testbench to project 
project addfile ${TB}/${TESTBENCH}.sv

# Add testvector to project 
project addfile ${TV}/${TESTVECTOR}.txt

# ^ RUN THE ABOVE IF THE PROJECT DOESNT EXIST, OTHERWISE MAKE A NEW PROJECT

# compile all files in the project 
project compileall



# used in wally, perhaps more complex than I need. 
#vlog -lint -work ${WKDIR} +incdir+${SRC} +incdir+${TV} +incdir+${TB} ${SRC}/${DUT}.sv ${SRC}/*.sv 

#vsim -do "run -all" ${TESTBENCH}

quit