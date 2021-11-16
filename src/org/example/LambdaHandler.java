package org.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import java.util.HashMap;
import java.util.Map;

public class LambdaHandler implements RequestHandler<Object, Object> {

    @Override
    public Object handleRequest(Object o, Context context) {
        context.getLogger().log(o.toString());

        //code goes here

        Map<String,String> headers = new HashMap<>();
        headers.put("Content-type", "application/json");

        return new org.example.Response("{}", headers, 200);
    }
}
