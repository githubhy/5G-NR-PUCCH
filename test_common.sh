# cordic_rot
# compile_verilog common/cordic_rot.sv tb/cordic_rot_tb.sv > logs/cordic_rot.log; cat logs/cordic_rot.log

# mod_comb
# compile_verilog common/mod_comb.sv tb/mod_comb_tb.sv > logs/mod_comb_tb.log; cat logs/mod_comb_tb.log

# complex_cycle
# compile_verilog common/complex_cycle.sv tb/complex_cycle_tb.sv > logs/complex_cycle_tb.log; cat logs/complex_cycle_tb.log

# c_seq_gen
# compile_verilog common/x1_seq_gen.sv common/x2_seq_gen.sv common/c_seq_gen.sv tb/c_seq_gen_tb.sv > logs/c_seq_gen_tb.log; cat logs/c_seq_gen_tb.log

# c_seq_gen_control
# compile_verilog common/c_seq_gen_control.sv common/x1_seq_gen.sv common/x2_seq_gen.sv common/c_seq_gen.sv tb/c_seq_gen_control_tb.sv > logs/c_seq_gen_control_tb.log; cat logs/c_seq_gen_control_tb.log

# cyc_24_lowPAPRS
# compile_verilog common/cyc_24.sv common/cyc_24_base_seq.sv common/varphi12.sv common/cyc_24_lowPAPRS_generator.sv common/c_seq_gen.sv common/x1_seq_gen.sv common/x2_seq_gen.sv common/mod_comb.sv tb/cyc_24_lowPAPRS_generator_tb.sv > logs/cyc_24_lowPAPRS_generator_tb.log; cat logs/cyc_24_lowPAPRS_generator_tb.log

# pucch1
# compile_verilog common/pucch1.sv common/bpsk_cyc.sv common/qpsk_cyc.sv common/cyc_24.sv common/cyc_24_base_seq.sv common/varphi12.sv common/cyc_24_lowPAPRS_generator.sv common/c_seq_gen.sv common/x1_seq_gen.sv common/x2_seq_gen.sv common/mod_comb.sv tb/pucch1_tb.sv > logs/pucch1_tb.log; cat logs/pucch1_tb.log

# PUCCH1Spreading
# compile_verilog common/pucch1_spread.sv tb/pucch1_spread_tb.sv > logs/pucch1_spread_tb.log; cat logs/pucch1_spread_tb.log

#  cyc_12_alpha_generator
# compile_verilog common/mod_comb.sv common/cyc_12_alpha_generator.sv common/c_seq_gen_control.sv common/x1_seq_gen.sv common/x2_seq_gen.sv common/c_seq_gen.sv tb/cyc_12_alpha_generator_tb.sv > logs/cyc_12_alpha_generator_tb.log; cat logs/cyc_12_alpha_generator_tb.log

# pucch
compile_verilog\
 tb/pucch_tb.sv common/pucch.sv\
 common/mod_comb.sv common/bpsk_cyc.sv common/qpsk_cyc.sv\
 common/cyc_12_alpha_generator.sv common/cyc_24_base_seq.sv common/cyc_24.sv\
 common/c_seq_gen_control.sv common/varphi12.sv common/c_seq_gen.sv\
 common/pucch1_spread.sv\
 common/x1_seq_gen.sv common/x2_seq_gen.sv > logs/pucch_tb.log; cat logs/pucch_tb.log;






