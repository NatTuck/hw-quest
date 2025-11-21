---
title: "cs4140 Notes: 11-21 Using LLMs"
date: "2025-11-19"
---

## We want to use an LLM from our app

Two choices:

- Embed in app
  - Python Transformers or port (e.g. Transformers.js)
  - llama.cpp library
- Call out to an API endpoint.
  - Llama.cpp
  - Python ecosystem: vLLM
  - Both are OpenAI API compatible

## Embedding example: Running in browser

Show <https://github.com/NatTuck/bchat> and bchat.fogcloud.org

## Example: HW Starter Code

Start by downloading the HW13 starter code.

To enable logging:

```xml
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-simple</artifactId>
      <version>2.0.17</version>
    </dependency>
```

Or we can disable by instead including:

```xml
    <dependency>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-nop</artifactId>
      <version>2.0.17</version>
    </dependency>
```

Now let's run the starter code.

## Sample Problem: Count animals in picture

```bash
mvn compile exec:java -Dexec.args=/home/nat/Code/hw-quest/content/classes/2025-09/cs2381/notes/z_four_ducks.jpg
```

Test images:

- [bears](../z_three_bears.jpg)
- [ducks](../z_four_ducks.jpg)

This wants to run against a VL model, like
[Qwen3-VL-30B-A3B-Instruct](https://huggingface.co/Qwen/Qwen3-VL-30B-A3B-Instruct).

Note that running VL models with llama.cpp requires both the model gguf and a
mmproj gguf.

```java
package dslabs;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;
import java.io.IOException;

import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.data.message.ImageContent;
import dev.langchain4j.data.message.TextContent;
import dev.langchain4j.model.output.Response;

public class App {
    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            throw new RuntimeException("Expected image path as args[1]");
        }

        var img = new ImageContent(jpegToBase64(args[0]), "image/jpeg");
        System.out.println("Got image of type " + img.image().mimeType());

        var model = LocalModel.getModel();

        UserMessage userMessage = UserMessage.from(
                TextContent.from("How many animals are there in the image?"),
                img);

        var response = model.chat(userMessage);

        System.out.println(response);
    }

    public static String jpegToBase64(String path) throws IOException {
        byte[] bytes = Files.readAllBytes(Paths.get(path));
        return Base64.getEncoder().encodeToString(bytes);
    }
}
```

This works, but there's a minor problem:

- The function we've built is (english text, image) -> (english text).
- We need an LLM to deal with arbitrary english text.
- We don't want to be stuck in LLM-land forever, we'd like to get an
  answer that we can use in normal code.
- We want (english text, image) -> Integer.

```java
package dslabs;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;
import java.io.IOException;

import dev.langchain4j.data.message.ImageContent;
import dev.langchain4j.service.AiServices;
import dev.langchain4j.service.UserMessage;
import dev.langchain4j.service.V;

public class App {
    interface Counter {
        @UserMessage("How many {{what}} are in the image?")
        int getCount(@V("what") String what, @UserMessage ImageContent image);
    }

    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            throw new RuntimeException("Expected image path as args[1]");
        }

        var img = new ImageContent(jpegToBase64(args[0]), "image/jpeg");
        System.out.println("Got image of type " + img.image().mimeType());

        var model = LocalModel.getModel();
        var svc = AiServices.create(Counter.class, model);

        var response = svc.getCount("animals", img);

        System.out.println(response);
    }

    public static String jpegToBase64(String path) throws IOException {
        byte[] bytes = Files.readAllBytes(Paths.get(path));
        return Base64.getEncoder().encodeToString(bytes);
    }
}
```

## More to discuss

- Tools / Tool calling
- What the AiServices thing is doing.
- Multi-stage workflows with tool calling.
- Agents.
