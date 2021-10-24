# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  raise "Mental State Not Auditable" unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin  
  audit_sanity(bedtime_mental_state) == 0
  raise "Invalid mental state"
rescue Exception => ex
  puts ex.message
end

# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

def audit_sanity(bedtime_mental_state)
  return MorningMentalState.new() unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work

# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

class myCandyMachine < CandyMachine ; end

machine = myCandyMachine.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts "sadness"
end