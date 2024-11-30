`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:42:18
// Design Name: 
// Module Name: EmotionArtSystem_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EmotionArtSystem_tb;
    logic [511:0] image;                 
    logic [7:0] ascii_art [8][8];        // Flattened 64-element ASCII art output

    EmotionArtSystem dut (
        .image(image),
        .ascii_art(ascii_art)
    );

    initial begin
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8; j++) begin
                image[(i * 8 + j) * 8 +: 8] = (i * 32) + (j * 16) - 128;  
            end
        end

        #10;  

        $display("Generated ASCII Art:");
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8; j++) begin
                $write("%c ", ascii_art[i * 8 + j]);  
            end
            $display("");  
        end

        $finish;
    end

endmodule
