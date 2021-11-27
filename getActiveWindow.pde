import processing.net.*;
Server server;
int port = 5000;

void setup() {
  server = new Server(this, port);
}

void draw(){
   Client client = server.available();
  if (client ==null) return;

  println(client.readString());
  
  //String [] strings = split(client.readString(), "\n");
  //println()
}
