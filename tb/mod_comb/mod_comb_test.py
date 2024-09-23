# Function to generate input file with numbers from 0 to 65535 in hexadecimal format
def generate_input_file(filename="input.txt"):
    with open(filename, "w") as file:
        for num in range(2**16):  # Generates numbers from 0 to 65535
            file.write(f"{format(num, 'x')}\n")  # Write hex without '0x' prefix
    print(
        f"Input file '{filename}' generated with all 16-bit numbers in hex (no '0x')."
    )


# Function to perform modulo n test and write output file with results in hexadecimal format
def mod_n_test(input_filename="input.txt", output_filename="output.txt", mod_n=12):
    with open(input_filename, "r") as infile, open(output_filename, "w") as outfile:
        for line in infile:
            num = int(line.strip(), 16)  # Convert hex string to integer
            mod_result = num % mod_n  # Compute modulo n
            outfile.write(
                f"{format(mod_result, 'x')}\n"
            )  # Write hex result without '0x'
    print(
        f"Output file '{output_filename}' generated with modulo {mod_n} results in hex (no '0x')."
    )


if __name__ == "__main__":
    mod_n_value = 192  # You can change this value to any n for mod n
    input_file_name = f"input.txt"  # Input file name
    output_file_name = f"mod_{mod_n_value}_output.txt"  # Output file name

    # Generate input file and compute mod n results
    generate_input_file(input_file_name)
    mod_n_test(
        input_filename=input_file_name,
        output_filename=output_file_name,
        mod_n=mod_n_value,
    )
