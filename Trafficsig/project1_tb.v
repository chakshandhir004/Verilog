module stimulus;
wire[1:0] main,cntry;
reg car_on_cntry_rd;
reg clock,clear;

sig_control SC(main,cntry,car_on_cntry_rd,clock,clear);
initial begin
    $monitor($time,"main=%b cntry=%b car_on_cntry_rd=%b",main,cntry,car_on_cntry_rd);

end

initial begin
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
    
    #100 $stop;
end


endmodule