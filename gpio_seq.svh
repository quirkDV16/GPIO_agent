class gpio_seq extends uvm_sequence #(gpio_seq_item);

// UVM Factory Registration Macro
//
`uvm_object_utils(gpio_seq)

//------------------------------------------
// Data Members (Outputs rand, inputs non-rand)
//------------------------------------------
rand logic[31:0] data;

//------------------------------------------
// Constraints
//------------------------------------------



//------------------------------------------
// Methods
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "gpio_seq");
extern task body;

endclass:gpio_seq

function gpio_seq::new(string name = "gpio_seq");
  super.new(name);
endfunction

task gpio_seq::body;
  gpio_seq_item req;

  begin
    req = gpio_seq_item::type_id::create("req");
    start_item(req);
    if (!req.randomize() with {req.gpio == data;}) begin
      `uvm_error("RND_ERROR", "Error randomizing GPIO Request");
    end
    finish_item(req);
  end

endtask:body

class gpio_rand_seq extends uvm_sequence #(gpio_seq_item);

  `uvm_object_utils(gpio_rand_seq)

  function new(string name = "gpio_rand_seq");
    super.new(name);
  endfunction

  task body;
    gpio_seq_item rand_pkt = gpio_seq_item::type_id::create("rand_pkt");

    forever begin
      start_item(rand_pkt);
      assert(rand_pkt.randomize());
      finish_item(rand_pkt);
    end

  endtask: body

endclass: gpio_rand_seq
