class ApplicationAgent < ActiveAgent::Base
  layout "agent"
  generate_with :openai, instructions: "You are a helpful assistant.",
    model: "gpt-4o-mini",
    temperature: 0.7
end
