all:
	@macrubyc teatime.rb -o /usr/local/bin/teatime

clean:
	@rm teatime.o
	@rm /usr/local/bin/teatime