package com.iac.poc;

import com.microsoft.azure.functions.*;
import com.microsoft.azure.functions.annotation.*;

import java.util.Optional;

/**
 * Azure Functions with HTTP Trigger.
 */
public class MessageSenderFunction {

    /**
     * This function will be invoked when an HTTP request is received.
     */
    @FunctionName("sendMessage")
    public HttpResponseMessage run(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, authLevel = AuthorizationLevel.ANONYMOUS, route = "send/{message}") HttpRequestMessage<Optional<String>> request,
            @ServiceBusQueueOutput(name = "out", queueName = "sb-poc-queue-1", connection = "AzureWebJobsServiceBus") OutputBinding<String> outputItem,
            final ExecutionContext context, @BindingName("message") String message) {

        context.getLogger().info("Received message " + message + " - adding message to queue");

        // set the message from URI parameter to the Service Bus queue
        outputItem.setValue(message);

        // Return a response message
        return request.createResponseBuilder(HttpStatus.OK).body("Message sent to the queue: " + message).build();
    }

}
