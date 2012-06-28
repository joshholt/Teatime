require 'trollop'
framework "cocoa"
framework "foundation"
framework "ApplicationServices"
framework "QuartzCore"

class Teatime

  def speakString
    @pool = NSAutoreleasePool.alloc.init
    synth = NSSpeechSynthesizer.alloc.init
    synth.startSpeakingString("Your tea has finished steeping")
  end

  def run(time, flashes, useVoiceToo)
    sleep time * 60

    if useVoiceToo
      speakString
    end


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

    CGReleaseDisplayFadeReservation(fadeToken[0])
    @pool.drain
  end

end


opts = Trollop::options do
  version "teatime 0.0.1"
  banner <<-EOS
  Teatime is a simple way to get notifications when your tea has finished
  steeping.

  The types of notifications: 
    Flashing Screen
    (optional) A Voice speaking to you

  Usage:
      teatime [options]

  where [options] are:
  EOS

  opt :d, "Number of minutes", :type => :float
  opt :f, "Number of flashes", :default => 4
  opt :v, "Include voice notification"
end

Trollop::die :d, "Number of minutes must be provided" if opts.d.nil?

Teatime.new().run(opts.d, opts.f, opts.v)