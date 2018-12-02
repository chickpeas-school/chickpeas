class MassMessage < ApplicationRecord
  has_and_belongs_to_many :parents

  def send_sms
    aws_client = Aws::SNS::Client.new
    parents.each do |parent|
      resp = aws_client.publish(
        phone_number: parent.formatted_phone_number,
        message: message
      )

      puts """
        SNS Message: #{resp.message_id}
        Message Content: #{message}
        Parent Number: #{parent.formatted_phone_number}
      """
    end

    sent = true
    save
  end
end
