transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/ModelSim\ for\ Lab4 {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/ModelSim for Lab4/task2_fsm.v}
vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/ModelSim\ for\ Lab4 {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/ModelSim for Lab4/task1.v}
vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/template_de1soc {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/template_de1soc/ksa.v}
vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/template_de1soc {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/template_de1soc/s_memory.v}
vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/template_de1soc {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/template_de1soc/d_memory.v}
vlog -sv -work work +incdir+//Mac/Home/Desktop/UBC/3rd\ Year/Winter2/CPEN311/LAB4/template_de1soc {//Mac/Home/Desktop/UBC/3rd Year/Winter2/CPEN311/LAB4/template_de1soc/sevensegmentdisplaydecoder.v}

