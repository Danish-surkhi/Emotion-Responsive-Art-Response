`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 11:39:47
// Design Name: 
// Module Name: ASCIIConverter
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


module ASCIIConverter (
    input logic signed [7:0] generated_image [8][8],  
    output logic [7:0] ascii_art [8][8]               
);

    logic [7:0] ASCII_CHARS [0:9] = { "64", "35", "37", "38", "42", "43", "61", "45", "46", "32" };

    function logic [3:0] intensity_to_ascii_index (input logic signed [7:0] pixel_value);
        logic unsigned [7:0] abs_value;
        abs_value = pixel_value + 8'sd128;
        intensity_to_ascii_index = abs_value / 25;
    endfunction

    always_comb begin
        for (int i = 0; i < 8; i++) begin
            for (int j = 0; j < 8; j++) begin
                ascii_art[i][j] = ASCII_CHARS[intensity_to_ascii_index(generated_image[i][j])];
            end
        end
    end

endmodule
