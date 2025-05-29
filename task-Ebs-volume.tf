#create an instance and attch an Ebs volume of 30gb-gp3-1a
resource "aws_instance" "instance" {
  ami               = "ami-0af9569868786b23a"  
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
 
  tags = {
    Name = "girish-Instance"
  }
}

resource "aws_ebs_volume" "volume" {
  availability_zone = "ap-south-1a"
  size              = 30
  type              = "gp3"

  tags = {
    Name = "girishVolume"
  }
}

resource "aws_volume_attachment" "example_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.instance.id
}