all:
	@export PATH=~/bin:$PATH
	@macrubyc teatime.rb -o ~/bin/teatime

clean:
	@rm teatime.o
	@rm ~/bin/teatime