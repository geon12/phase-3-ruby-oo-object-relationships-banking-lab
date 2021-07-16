class Transfer

  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def meets_conditions?
    pending_status = @status == 'pending'
    sender_balance = @sender.balance > @amount
    
    self.valid? && pending_status && sender_balance
  end

  def execute_transaction
    if meets_conditions?
      @receiver.balance += @amount
      @sender.balance -= @amount
      @status = 'complete'
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."

    end
  end

  def reverse_transfer
    if @status == 'complete'
      @receiver.balance -= @amount
      @sender.balance += @amount

      @status = 'reversed'
    end
  end
end
