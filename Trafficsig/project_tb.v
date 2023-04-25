module stimulus;
wire[1:0] main,cntry; //Value of signal (Red,yellow,green)
reg car_on_cntry_rd; //X
reg clock,clear;

sig_control SC(main,cntry,car_on_cntry_rd,clock,clear); //Instantiating module

initial begin
    $monitor($time ," main=%b cntry=%b car_on_cntry_rd=%b clear=%b",main,cntry,car_on_cntry_rd,clear);

end

initial begin              // Clock generator
    clock=`FALSE;
    forever #5 clock=~clock;
end

initial begin
    clear=`TRUE;
    repeat (5) @(negedge clock);
    clear=`FALSE;
end

initial begin
    car_on_cntry_rd=`FALSE;

    #200 car_on_cntry_rd=`TRUE;
    #100 car_on_cntry_rd=`FALSE;

    #200 car_on_cntry_rd=`TRUE;
    #100 car_on_cntry_rd=`FALSE;
    
    #200 car_on_cntry_rd=`TRUE;
    #100 car_on_cntry_rd=`FALSE;
    
    #100 $finish;
end


endmodule