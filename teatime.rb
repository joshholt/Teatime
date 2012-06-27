framework "cocoa"
framework "foundation"
framework "ApplicationServices"
framework "QuartzCore"

class Teatime

	def run(time, flashes)
		sleep time


    fadeToken = Pointer.new('I')
    err = CGAcquireDisplayFadeReservation(15.0, fadeToken)
    if err == 0
    	flashes.times do 
    		CGDisplayFade(fadeToken[0], 0.2, 0.0, 1.0, 0.0, 0.0, 0.0, true)
    		CGDisplayFade(fadeToken[0], 0.2, 1.0, 0.0, 0.0, 0.0, 0.0, true)
    	end
    else
    	puts "Couldn't acquire Fade Res..."
		end
	end

end


duration = ARGV[0].to_i
flashes  = 4
if !ARGV[1].nil?
	flashes = ARGV[1].to_i
end

Teatime.new().run(duration, flashes)