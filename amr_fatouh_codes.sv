// defining module
// ===============
module module_name(param1, param2, param3, param4); endmodule

// declaration
// ===========
parameter CYCLE = 20;

input param1, param2;
output param3, param4;

wire param1; // all input ports are wires
reg clk;
logic logic1;

bit b;
bit [31:0] b32;

byte b8;
shortint s;
int i;
int unsigned ui;
loginint l;

integer i4;
time t;
real r;


// declaring modules
// ================= 
not n1(out, in);
my_module m1(out1, out2, in1, in2, in3);

// arrays declaration
// ==================
int lo_hi[0:15]; // array of size 16
int c_style[16];
int a[0:7][0:3]; // 8x4 array
int a[8][4];
int arr[4] = '{1,2,3,4};
int arr[4] = '{1,2,3}; // WRONG - all must be initialized
bit [31:0] src; // packed
bit src[5]; // unpacked
bit [31:0] arr[5];
bit [1:0] arr = 1; // arr[0] = 1  // highest index (1) is the MSB
bit [0:1] arr = 1; // arr[1] = 1  // highest index (1) is the LSB
int dyn[]; // dynamic array
bit [39:0] assoc[int]; // associative array; key is int, value is 40 bits
int q[$] = {3,4}; // queue

// display directive
// =================
$display("a");
$display("a", "b");
$display("%d", a); // decimal
$display("%0d", a); // decimal - take space as small as possible (take space of 0 char or more)
$display("%5d", a); // decimal - take space of 5 chars or more
$displayd(a); // decimal
$display("%b", b); //binary
$displayb(b); //binary
$write("a"); // write to buffer
$display; // display what is in buffer and insert a new line after it in the console
$display("%s", "a"); //string
$display("a",,"b"); // "a b"  // space
$display("%t", $time); // time

// other directives
// ================
$size(arr);

// assignment
// ==========
assign logic1 = ~param1 // continuous
a = 1'b0; // blocking
a <= 1'b0; // non blocking
a = 1'bx; // 1 don't care bit 
a = 4'b11; //0011 (padding with 0s)
a = 4'hA; // hexadecimal
int a = 1'bx; //0 (don't care bits converted to zeros in 2 states data types)
real r = 3.25; //3.25
bit [9:0] bit_arr = 5'b11111; //0000011111 // assigning to an array
a = 8'b1111_1111; // using underscore
bit a = 4'b1111; // truncating to 1



// array assignemnt
// ================
arr[1] = 1;
arr[1][1] = 1;
arr = {1,2,3,4}; // size of arr must be 4
arr[0:2] = {1,2,3}; // bit 3 is not changed
arr = '{4{8}}; // {8,8,8,8}  // arr size must be 4
arr = '{default: 8}; // {8,8,8,8}  // arr can be of any size
arr1 = arr2; // assign an array to the other
bit [1:0] [3:0] arr1; bit [3:0] arr2; arr1[0] = arr2; // assigning array to another

arr1 == arr2 // compare arrays

dyn = new[5]; // allocate 5 elements to dynamic array - override array content
dyn = dyn2; // copy dynamic array into another one
dyn = new[20](dyn2); // allocate 20 elements in dyn array and copy dyn2 array

// queue assignement
// =================
q = {q[0:1], 20, q[2:$]}; // insert 20 at index 2
q = {q[0:1], q2, q[2:$]}; // insert queue (q2) starting from index 2
q = {q[0:1], q[3:$]}; // delete element at index 2
q = {q, 20}; // insert 20 at the back of the queue
q = {20, q}; // insert 20 at the front of the queue
q = q[0:$-1]; // remove last element
q = [1:$]; // remove last element
q = {}; // remove all elements
x = q[0]; // get first element
x = q[$]; // get last element

// arrays functions
// ================
dyn.delete(); // remove all elements from array
assoc.first(index); // put the first key of assoc array into index variable - returns 1 (there is an element) or 0 (there is no element)
assoc.next(index); // put the next key of assoc array into index variable - returns 1 (there is an element) or 0 (there is no element)
  // examples
  // 1
  assoc[0] = 0;
  $display(assoc.first(index)); // 1  // there is an element in the array

  // 2
  assoc.delete();
  $display(assoc.first(index)); // 0  // there is no elements in the array

  // 3
  assoc[0] = 0;
  $display(assoc.next(index)); // 1  // there is an element in the array
  $display(assoc.next(index)); // 0  // there is no next element the array

  // 4
  assoc[0] = 0;
  assoc.next(index);
  $display(index); // 0  // first key of array
  
  // 5
  assoc[0] = 0;
  $display(assoc.next(index)); // 1  // there is an element in the array
  $display(assoc.first(index)); // 1  // there is an element in the array
  $display(assoc.next(index)); // 0  // there is no next element in the array  // first function does not reset next function counter


assoc.delete(index); // remove that key from the array
assoc.exists("max_address"); // check whether key exists or not
arr.sum; // sum of all array elements
bits.sum with (int'(item)); // cast each array element into int before adding (not to truncate bits when added)
arr.sum with (int'(item > 7)); // count number of items greater than 7
arr.sum with (int'(item > 7) * item); // sum of items greater than 7
arr.sum with (item > 7 ? item : 0); // sum of items greater than 7
arr.max; // returns an array containing the max element
arr.min; // returns an array containing the min element
arr.unique; // returns an array containing same array elements with no duplicates
arr.find with (item > 7); // returns an array containing elements greater than 7
arr.find_index with (item > 7); // returns an array of indecies of elemnts greater than 7
arr.find_first with (item > 7); // first element > 7
arr.find_first_index with (item > 7); // index of 1st element > 7
arr.find_last with (item > 7); // last element > 7
arr.find_last_index with (item > 7); // index of last element > 7
arr.reverse(); // reverse order of array
arr.sort(); // sort array
arr.rsort(); // sort array in reverse
arr.shuffle(); // shuffle array
arr.size(); // size of assoc and dyn arrays (not for fixed - use $size(arr) instead)

// queue functions
// ===============
q.insert(1, 20); // insert 20 at index 1
q.push_back(20); // insert 20 at the end of queue
q.push_front(20); // insert 20 at the start of the queue
q.pop_back(); // remove last element in the queue
q.pop_front(); // remove first element in the queue
q.delete(1); // remove element at index 1
q.delete(); // remove all elements
q.max; // returns an queue containing the max element
q.min; // returns an queue containing the min element
q.unique; // returns an queue containing same queue elements with no duplicates
// does all array function are valid for queues?

// casting
// =======
int i = 10.0 - 0.6; // 9 // implicit casting (rounding - not flooring)
int i = 10.0 - 0.4; // 10 // implicit casting (rounding)
int i = int'(10.0 - 0.6); // 9 // optional casting
int i = {>>{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xffeeddcc // pack
int i = {<<8{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xccddeeff // reverse bits and pack - 8 bits
int i = {<<16{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xddccffee // reverse bits and pack - 16 bits
int i = {<<24{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xeeddccff // reverse bits and pack - 24 bits
bit [7:0] b = {<<{8'b1011_0000}}; // 0000_1101  // reverse bits

// expression width
// ================
$displayb(1'b1 + 1'b1); // 0
bit [7:0] bits = 1'b1 + 1'b1; // 2  // summation is done correctly
real r = 3 / 2; // 1  // division is done wrong, though
$display(1 + 2.5); // 3.5  // automatic casting to real
$display(3 / 2); // 1  // no casting
$display(3 / 2.0); // 1  // automatic casting to real
$display(1'b1 + 1'b1 + 2'b0); // 2  // automatic casting to 2 bits (same as automatic casting to real when adding int to real)
$display(2'(1'b1) + 1'b1); // 2  // casting into 2 bits
$displayb(4'(1'b1) + 1'b1); // 0010  // casting into 4 bits

// strings
// =======
s.getc(0); // get first char
s.tolower(); // lower case
s.toupper(); // upper case
s.putc(1, "a"); // replace char at index 1 with "a"
s = {s, "aaa"}; // concatinate s with "aaa"
s.substr(2, 5); // return a new string with characters from char at index 2 to char at index 5
string s = $psprintf("%b", 4'b1010); // return a string formatted the same way as $display directive

// flow control
// ============
initial begin end
initial begin 
  #5 //after 5 ns
end
initial begin 
  forever begin end // same as always
end


always begin end
always @(posedge clk) begin end


if (1 == 1) begin end
case (x)
  0: $display("0");
  1: $display("1");
  default: $display("default");
endcase


for (int i = 0; i < $size(arr); i++) begin end
repeat (20) begin end

foreach(arr[j]) begin end
foreach(arr[i, j]) begin end // 2d array
foreach(arr[i]) begin // 2d array - step through the rows
  foreach(arr[,j]) begin end // step through the columns
end
foreach(assoc[i]) begin end // iterate through valid associative array keys

// files
// =====
int file; // file handles are ints
file = $fopen("switch.txt", "r"); // create a file handler
while(!$feof(file)) begin end // loop on the file contents

int i;
string s;
$fscanf(file, "%d %s", i, s); // read decimal - space - string respectively from the file

$fclose(file); // close file

// enums
// =====
typedef enum { INIT, DECODE, IDLE } fsmstate_e; // defining enum
fsmstate_e nstate = INIT; // declaring an enum variable 
$display(nstate); // 0
$display(nstate.name()); // INIT
nstate.first; // INIT  // get first enum
nstate.next; // DECODE  // get next enum

typedef enum {RED, BLUE = 2, GREEN} color_e;
color_e color = BLUE;
$display(color); // 2
$display(color.name()); // BLUE
color = color.next;
$display(color); // 3
$display(color.name()); // GREEN

// struct
// ======
typedef struct { // defining a struct
  bit [7:0] addr;
  bit [7:0] pr;
  bit [15:0] data;
} Packet; 

Packet p = '{100, 2, 365}; // assigning to a struct
p.addr; // accessing struct fields

typedef struct {bit [7:0] r, g, b;} pixels_s; // each instance take 3 words of memory
typedef struct packed {bit [7:0] r, g, b;} pixels_s; // each instance take 1 word of memory

// union
// =====
typedef union { int i; real f; } num_u;
num_u un = 25.432; //'{i: -1924545349, f: 25.432}

// creating new types
// ==================
typedef reg[7:0] opreg_t; // define 8-bit reg type
typedef bit[31:0] uint_t; // define unsigned int through 32 bits
typedef int unsigned uint1_t; // define short for unsigned int
typedef int fixed_array5[5]; // define a data type of array of 5 ints

// functions
// =========

function void f(int x); endfunction

task t(int x); endtask // similar to void function

// snippet written in test bench for graphing
initial begin 
  $dumpfile("uvm.vcd");
  $dumpvars;
  #200 $finish
end// defining module
// ===============
module module_name(param1, param2, param3, param4); endmodule

// declaration
// ===========
parameter CYCLE = 20;

input param1, param2;
output param3, param4;

wire param1; // all input ports are wires
reg clk;
logic logic1;

bit b;
bit [31:0] b32;

byte b8;
shortint s;
int i;
int unsigned ui;
loginint l;

integer i4;
time t;
real r;


// declaring modules
// ================= 
not n1(out, in);
my_module m1(out1, out2, in1, in2, in3);

// arrays declaration
// ==================
int lo_hi[0:15]; // array of size 16
int c_style[16];
int a[0:7][0:3]; // 8x4 array
int a[8][4];
int arr[4] = '{1,2,3,4};
int arr[4] = '{1,2,3}; // WRONG - all must be initialized
bit [31:0] src; // packed
bit src[5]; // unpacked
bit [31:0] arr[5];
bit [1:0] arr = 1; // arr[0] = 1  // highest index (1) is the MSB
bit [0:1] arr = 1; // arr[1] = 1  // highest index (1) is the LSB
int dyn[]; // dynamic array
bit [39:0] assoc[int]; // associative array; key is int, value is 40 bits
int q[$] = {3,4}; // queue

// display directive
// =================
$display("a");
$display("a", "b");
$display("%d", a); // decimal
$display("%0d", a); // decimal - take space as small as possible (take space of 0 char or more)
$display("%5d", a); // decimal - take space of 5 chars or more
$displayd(a); // decimal
$display("%b", b); //binary
$displayb(b); //binary
$write("a"); // write to buffer
$display; // display what is in buffer and insert a new line after it in the console
$display("%s", "a"); //string
$display("a",,"b"); // "a b"  // space
$display("%t", $time); // time

// other directives
// ================
$size(arr);

// assignment
// ==========
assign logic1 = ~param1 // continuous
a = 1'b0; // blocking
a <= 1'b0; // non blocking
a = 1'bx; // 1 don't care bit 
a = 4'b11; //0011 (padding with 0s)
a = 4'hA; // hexadecimal
int a = 1'bx; //0 (don't care bits converted to zeros in 2 states data types)
real r = 3.25; //3.25
bit [9:0] bit_arr = 5'b11111; //0000011111 // assigning to an array
a = 8'b1111_1111; // using underscore
bit a = 4'b1111; // truncating to 1



// array assignemnt
// ================
arr[1] = 1;
arr[1][1] = 1;
arr = {1,2,3,4}; // size of arr must be 4
arr[0:2] = {1,2,3}; // bit 3 is not changed
arr = '{4{8}}; // {8,8,8,8}  // arr size must be 4
arr = '{default: 8}; // {8,8,8,8}  // arr can be of any size
arr1 = arr2; // assign an array to the other
bit [1:0] [3:0] arr1; bit [3:0] arr2; arr1[0] = arr2; // assigning array to another

arr1 == arr2 // compare arrays

dyn = new[5]; // allocate 5 elements to dynamic array - override array content
dyn = dyn2; // copy dynamic array into another one
dyn = new[20](dyn2); // allocate 20 elements in dyn array and copy dyn2 array

// queue assignement
// =================
q = {q[0:1], 20, q[2:$]}; // insert 20 at index 2
q = {q[0:1], q2, q[2:$]}; // insert queue (q2) starting from index 2
q = {q[0:1], q[3:$]}; // delete element at index 2
q = {q, 20}; // insert 20 at the back of the queue
q = {20, q}; // insert 20 at the front of the queue
q = q[0:$-1]; // remove last element
q = [1:$]; // remove last element
q = {}; // remove all elements
x = q[0]; // get first element
x = q[$]; // get last element

// arrays functions
// ================
dyn.delete(); // remove all elements from array
assoc.first(index); // put the first key of assoc array into index variable - returns 1 (there is an element) or 0 (there is no element)
assoc.next(index); // put the next key of assoc array into index variable - returns 1 (there is an element) or 0 (there is no element)
  // examples
  // 1
  assoc[0] = 0;
  $display(assoc.first(index)); // 1  // there is an element in the array

  // 2
  assoc.delete();
  $display(assoc.first(index)); // 0  // there is no elements in the array

  // 3
  assoc[0] = 0;
  $display(assoc.next(index)); // 1  // there is an element in the array
  $display(assoc.next(index)); // 0  // there is no next element the array

  // 4
  assoc[0] = 0;
  assoc.next(index);
  $display(index); // 0  // first key of array
  
  // 5
  assoc[0] = 0;
  $display(assoc.next(index)); // 1  // there is an element in the array
  $display(assoc.first(index)); // 1  // there is an element in the array
  $display(assoc.next(index)); // 0  // there is no next element in the array  // first function does not reset next function counter


assoc.delete(index); // remove that key from the array
assoc.exists("max_address"); // check whether key exists or not
arr.sum; // sum of all array elements
bits.sum with (int'(item)); // cast each array element into int before adding (not to truncate bits when added)
arr.sum with (int'(item > 7)); // count number of items greater than 7
arr.sum with (int'(item > 7) * item); // sum of items greater than 7
arr.sum with (item > 7 ? item : 0); // sum of items greater than 7
arr.max; // returns an array containing the max element
arr.min; // returns an array containing the min element
arr.unique; // returns an array containing same array elements with no duplicates
arr.find with (item > 7); // returns an array containing elements greater than 7
arr.find_index with (item > 7); // returns an array of indecies of elemnts greater than 7
arr.find_first with (item > 7); // first element > 7
arr.find_first_index with (item > 7); // index of 1st element > 7
arr.find_last with (item > 7); // last element > 7
arr.find_last_index with (item > 7); // index of last element > 7
arr.reverse(); // reverse order of array
arr.sort(); // sort array
arr.rsort(); // sort array in reverse
arr.shuffle(); // shuffle array
arr.size(); // size of assoc and dyn arrays (not for fixed - use $size(arr) instead)

// queue functions
// ===============
q.insert(1, 20); // insert 20 at index 1
q.push_back(20); // insert 20 at the end of queue
q.push_front(20); // insert 20 at the start of the queue
q.pop_back(); // remove last element in the queue
q.pop_front(); // remove first element in the queue
q.delete(1); // remove element at index 1
q.delete(); // remove all elements
q.max; // returns an queue containing the max element
q.min; // returns an queue containing the min element
q.unique; // returns an queue containing same queue elements with no duplicates
// does all array function are valid for queues?

// casting
// =======
int i = 10.0 - 0.6; // 9 // implicit casting (rounding - not flooring)
int i = 10.0 - 0.4; // 10 // implicit casting (rounding)
int i = int'(10.0 - 0.6); // 9 // optional casting
int i = {>>{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xffeeddcc // pack
int i = {<<8{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xccddeeff // reverse bits and pack - 8 bits
int i = {<<16{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xddccffee // reverse bits and pack - 16 bits
int i = {<<24{8'hff, 8'hee, 8'hdd, 8'hcc}}; // 0xeeddccff // reverse bits and pack - 24 bits
bit [7:0] b = {<<{8'b1011_0000}}; // 0000_1101  // reverse bits

// expression width
// ================
$displayb(1'b1 + 1'b1); // 0
bit [7:0] bits = 1'b1 + 1'b1; // 2  // summation is done correctly
real r = 3 / 2; // 1  // division is done wrong, though
$display(1 + 2.5); // 3.5  // automatic casting to real
$display(3 / 2); // 1  // no casting
$display(3 / 2.0); // 1  // automatic casting to real
$display(1'b1 + 1'b1 + 2'b0); // 2  // automatic casting to 2 bits (same as automatic casting to real when adding int to real)
$display(2'(1'b1) + 1'b1); // 2  // casting into 2 bits
$displayb(4'(1'b1) + 1'b1); // 0010  // casting into 4 bits

// strings
// =======
s.getc(0); // get first char
s.tolower(); // lower case
s.toupper(); // upper case
s.putc(1, "a"); // replace char at index 1 with "a"
s = {s, "aaa"}; // concatinate s with "aaa"
s.substr(2, 5); // return a new string with characters from char at index 2 to char at index 5
string s = $psprintf("%b", 4'b1010); // return a string formatted the same way as $display directive

// flow control
// ============
initial begin end
initial begin 
  #5 //after 5 ns
end
initial begin 
  forever begin end // same as always
end


always begin end
always @(posedge clk) begin end


if (1 == 1) begin end
case (x)
  0: $display("0");
  1: $display("1");
  default: $display("default");
endcase


for (int i = 0; i < $size(arr); i++) begin end
repeat (20) begin end

foreach(arr[j]) begin end
foreach(arr[i, j]) begin end // 2d array
foreach(arr[i]) begin // 2d array - step through the rows
  foreach(arr[,j]) begin end // step through the columns
end
foreach(assoc[i]) begin end // iterate through valid associative array keys

// files
// =====
int file; // file handles are ints
file = $fopen("switch.txt", "r"); // create a file handler
while(!$feof(file)) begin end // loop on the file contents

int i;
string s;
$fscanf(file, "%d %s", i, s); // read decimal - space - string respectively from the file

$fclose(file); // close file

// enums
// =====
typedef enum { INIT, DECODE, IDLE } fsmstate_e; // defining enum
fsmstate_e nstate = INIT; // declaring an enum variable 
$display(nstate); // 0
$display(nstate.name()); // INIT
nstate.first; // INIT  // get first enum
nstate.next; // DECODE  // get next enum

typedef enum {RED, BLUE = 2, GREEN} color_e;
color_e color = BLUE;
$display(color); // 2
$display(color.name()); // BLUE
color = color.next;
$display(color); // 3
$display(color.name()); // GREEN

// struct
// ======
typedef struct { // defining a struct
  bit [7:0] addr;
  bit [7:0] pr;
  bit [15:0] data;
} Packet; 

Packet p = '{100, 2, 365}; // assigning to a struct
p.addr; // accessing struct fields

typedef struct {bit [7:0] r, g, b;} pixels_s; // each instance take 3 words of memory
typedef struct packed {bit [7:0] r, g, b;} pixels_s; // each instance take 1 word of memory

// union
// =====
typedef union { int i; real f; } num_u;
num_u un = 25.432; //'{i: -1924545349, f: 25.432}

// creating new types
// ==================
typedef reg[7:0] opreg_t; // define 8-bit reg type
typedef bit[31:0] uint_t; // define unsigned int through 32 bits
typedef int unsigned uint1_t; // define short for unsigned int
typedef int fixed_array5[5]; // define a data type of array of 5 ints

// functions
// =========

function void f(int x); endfunction

task t(int x); endtask // similar to void function

// snippet written in test bench for graphing
initial begin 
  $dumpfile("uvm.vcd");
  $dumpvars;
  #200 $finish
end