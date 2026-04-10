onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb/uut/clk
add wave -noupdate -radix unsigned /tb/uut/rst_n
add wave -noupdate -radix unsigned /tb/uut/peb
add wave -noupdate -radix unsigned /tb/uut/pec
add wave -noupdate -radix unsigned /tb/uut/pdb
add wave -noupdate -radix unsigned /tb/uut/pdc
add wave -noupdate -radix unsigned /tb/uut/peso_total
add wave -noupdate -radix unsigned /tb/uut/soma_esq
add wave -noupdate -radix unsigned /tb/uut/soma_dir
add wave -noupdate -radix unsigned /tb/uut/soma_completa
add wave -noupdate -radix unsigned /tb/uut/soma_tarada
add wave -noupdate -radix unsigned /tb/uut/carry_esq
add wave -noupdate -radix unsigned /tb/uut/carry_dir
add wave -noupdate -radix unsigned /tb/uut/carry_final
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {231 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {68 ns}
