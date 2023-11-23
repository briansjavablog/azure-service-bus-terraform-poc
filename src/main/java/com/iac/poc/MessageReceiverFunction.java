package com.iac.poc;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.ServiceBusQueueTrigger;

/**
 * Azure Functions with HTTP Trigger.
 */
public class MessageReceiverFunction {

    @FunctionName("receiveMessage")
    public void run(
            @ServiceBusQueueTrigger(name = "msg", queueName = "sb-poc-queue-1", connection = "AzureWebJobsServiceBus") String message,
            final ExecutionContext context) {

        context.getLogger().info("MessageReceiverFunction processed a message: " + message);
    }

}