-- LLMastery Seed Data
-- This script populates the database with initial content for the learning platform

-- Insert badges
INSERT INTO badges (name, description, image_url) VALUES
('First Lesson', 'Completed your first lesson', '/badges/first-lesson.svg'),
('Perfect Score', 'Got 100% on a quiz', '/badges/perfect-score.svg'),
('5-Day Streak', 'Learned for 5 consecutive days', '/badges/5-day-streak.svg'),
('LLM Fundamentals', 'Completed all fundamentals lessons', '/badges/fundamentals.svg'),
('Prompt Engineer', 'Completed all prompting lessons', '/badges/prompt-engineer.svg'),
('AI Architect', 'Completed all architecture lessons', '/badges/ai-architect.svg'),
('Training Expert', 'Completed all training lessons', '/badges/training-expert.svg');

-- Insert lessons
-- Lesson 1: Introduction to LLMs
WITH lesson1 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Introduction to LLMs',
    'Learn the basics of Large Language Models and how they work',
    '<h2>What are Large Language Models?</h2>
    <p>Large Language Models (LLMs) are a type of artificial intelligence model trained on vast amounts of text data to generate human-like text, translate languages, write different kinds of creative content, and answer questions in an informative way.</p>
    
    <h2>Key Components of LLMs</h2>
    <ul>
      <li><strong>Transformer Architecture</strong>: The foundation of modern LLMs</li>
      <li><strong>Self-Attention Mechanism</strong>: Allows models to weigh the importance of different words</li>
      <li><strong>Pre-training and Fine-tuning</strong>: Two-stage learning process</li>
      <li><strong>Tokenization</strong>: Converting text into numerical representations</li>
    </ul>
    
    <h2>Popular LLMs</h2>
    <p>Some well-known LLMs include GPT-4, Claude, Llama, PaLM, and Gemini. These models vary in size, capabilities, and use cases.</p>',
    'BEGINNER',
    'FUNDAMENTALS',
    15,
    100,
    150
  ) RETURNING id
),

-- Lesson 2: Transformer Architecture
lesson2 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Transformer Architecture',
    'Understanding the foundation of modern LLMs',
    '<h2>The Transformer Revolution</h2>
    <p>Introduced in the 2017 paper "Attention Is All You Need," the Transformer architecture revolutionized NLP by enabling parallel processing and better handling of long-range dependencies.</p>
    
    <h2>Core Components</h2>
    <ul>
      <li><strong>Encoder-Decoder Structure</strong>: Processing input and generating output</li>
      <li><strong>Multi-Head Attention</strong>: Allowing the model to focus on different parts of the input</li>
      <li><strong>Positional Encoding</strong>: Providing information about token positions</li>
      <li><strong>Feed-Forward Networks</strong>: Processing the attention outputs</li>
    </ul>
    
    <h2>Evolution of Transformers</h2>
    <p>Modern LLMs like GPT (Generative Pre-trained Transformer) use modified transformer architectures, often with decoder-only designs that scale to billions of parameters.</p>',
    'INTERMEDIATE',
    'ARCHITECTURE',
    20,
    120,
    180
  ) RETURNING id
),

-- Lesson 3: Prompt Engineering Basics
lesson3 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Prompt Engineering Basics',
    'Learn how to effectively communicate with LLMs',
    '<h2>What is Prompt Engineering?</h2>
    <p>Prompt engineering is the process of designing and refining inputs to AI models to get the most useful and appropriate responses for your specific needs.</p>
    
    <h2>Key Principles</h2>
    <ul>
      <li><strong>Clarity</strong>: Be precise about what you want</li>
      <li><strong>Context</strong>: Provide necessary background information</li>
      <li><strong>Format</strong>: Specify the desired output format</li>
      <li><strong>Examples</strong>: Demonstrate with few-shot learning</li>
    </ul>
    
    <h2>Basic Prompt Patterns</h2>
    <p>Common patterns include role prompting ("Act as a..."), format specification ("Respond in bullet points"), and task definition ("Summarize the following text in three sentences").</p>',
    'BEGINNER',
    'PROMPTING',
    10,
    100,
    150
  ) RETURNING id
),

-- Lesson 4: Advanced Prompting Techniques
lesson4 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Advanced Prompting Techniques',
    'Master chain-of-thought and other prompting strategies',
    '<h2>Chain-of-Thought Prompting</h2>
    <p>Chain-of-thought prompting involves guiding the model to break down complex reasoning into step-by-step thinking, significantly improving performance on tasks requiring multi-step reasoning.</p>
    
    <h2>Advanced Techniques</h2>
    <ul>
      <li><strong>Few-Shot Learning</strong>: Providing examples of desired input-output pairs</li>
      <li><strong>Self-Consistency</strong>: Generating multiple reasoning paths and taking a majority vote</li>
      <li><strong>Tree of Thoughts</strong>: Exploring multiple reasoning branches</li>
      <li><strong>ReAct</strong>: Combining reasoning and action in prompting</li>
    </ul>
    
    <h2>Instruction Optimization</h2>
    <p>Techniques like prefix optimization, where you find the best prefix for your instructions, and meta-prompting, where you guide the model to improve its own responses, can significantly enhance quality.</p>',
    'ADVANCED',
    'PROMPTING',
    25,
    150,
    200
  ) RETURNING id
),

-- Lesson 5: Fine-tuning Models
lesson5 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Fine-tuning Models',
    'Learn to adapt pretrained models for specific tasks',
    '<h2>What is Fine-tuning?</h2>
    <p>Fine-tuning is the process of further training a pre-trained model on a specific dataset to adapt it for specialized tasks or domains, enhancing its performance on targeted applications.</p>
    
    <h2>Fine-tuning Approaches</h2>
    <ul>
      <li><strong>Full Fine-tuning</strong>: Updating all model weights</li>
      <li><strong>Parameter-Efficient Fine-tuning</strong>: Methods like LoRA, adapters, and prompt tuning</li>
      <li><strong>Instruction Fine-tuning</strong>: Training on instruction-response pairs</li>
      <li><strong>RLHF</strong>: Reinforcement Learning from Human Feedback</li>
    </ul>
    
    <h2>Best Practices</h2>
    <p>Effective fine-tuning requires clean, diverse datasets, careful hyperparameter selection, evaluation strategies, and methods to prevent catastrophic forgetting of pre-trained capabilities.</p>',
    'ADVANCED',
    'TRAINING',
    30,
    150,
    200
  ) RETURNING id
),

-- Lesson 6: LLM Evaluation Methods
lesson6 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'LLM Evaluation Methods',
    'Understanding how to measure LLM performance',
    '<h2>Evaluation Challenges</h2>
    <p>Evaluating LLMs is complex due to their open-ended nature, subjective quality metrics, and the vast range of possible tasks they can perform.</p>
    
    <h2>Evaluation Approaches</h2>
    <ul>
      <li><strong>Benchmark Tests</strong>: Standardized tests like MMLU, BigBench, and HELM</li>
      <li><strong>Human Evaluation</strong>: Direct assessment by human raters</li>
      <li><strong>LLM-as-Judge</strong>: Using other LLMs to evaluate outputs</li>
      <li><strong>Automated Metrics</strong>: BLEU, ROUGE, perplexity, and others</li>
    </ul>
    
    <h2>Key Dimensions of Evaluation</h2>
    <p>Important aspects to evaluate include factual accuracy, reasoning ability, safety/alignment, robustness to adversarial inputs, and specialized domain knowledge.</p>',
    'INTERMEDIATE',
    'EVALUATION',
    20,
    120,
    180
  ) RETURNING id
),

-- Lesson 7: Ethical Considerations in LLMs
lesson7 AS (
  INSERT INTO lessons (title, description, content, level, category, duration, points, xp_reward)
  VALUES (
    'Ethical Considerations in LLMs',
    'Exploring the ethical implications of large language models',
    '<h2>Ethical Challenges</h2>
    <p>LLMs raise significant ethical concerns that practitioners must address, from bias and misinformation to privacy and environmental impact.</p>
    
    <h2>Key Issues</h2>
    <ul>
      <li><strong>Bias and Fairness</strong>: Models can perpetuate or amplify societal biases</li>
      <li><strong>Truthfulness</strong>: Hallucinations and factual accuracy concerns</li>
      <li><strong>Privacy</strong>: Data usage and memorization of training data</li>
      <li><strong>Transparency</strong>: Understanding model decisions and capabilities</li>
      <li><strong>Environmental Impact</strong>: The energy cost of training and running large models</li>
    </ul>
    
    <h2>Responsible AI Development</h2>
    <p>Approaches include red-teaming, alignment techniques, bias mitigation, responsible deployment practices, and ongoing monitoring and governance.</p>',
    'INTERMEDIATE',
    'ETHICS',
    25,
    130,
    190
  ) RETURNING id
),

-- Update lesson links (next/previous)
lesson_updates AS (
  -- Link lesson 1 to lesson 2
  UPDATE lessons SET next_lesson_id = (SELECT id FROM lesson2) WHERE id = (SELECT id FROM lesson1),
  
  -- Link lesson 2 to lessons 1 and 3
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson1), next_lesson_id = (SELECT id FROM lesson3) WHERE id = (SELECT id FROM lesson2),
  
  -- Link lesson 3 to lessons 2 and 4
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson2), next_lesson_id = (SELECT id FROM lesson4) WHERE id = (SELECT id FROM lesson3),
  
  -- Link lesson 4 to lessons 3 and 5
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson3), next_lesson_id = (SELECT id FROM lesson5) WHERE id = (SELECT id FROM lesson4),
  
  -- Link lesson 5 to lessons 4 and 6
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson4), next_lesson_id = (SELECT id FROM lesson6) WHERE id = (SELECT id FROM lesson5),
  
  -- Link lesson 6 to lessons 5 and 7
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson5), next_lesson_id = (SELECT id FROM lesson7) WHERE id = (SELECT id FROM lesson6),
  
  -- Link lesson 7 to lesson 6
  UPDATE lessons SET previous_lesson_id = (SELECT id FROM lesson6) WHERE id = (SELECT id FROM lesson7)
)

-- Insert quizzes for Lesson 1
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson1), 'What is the foundational architecture of modern LLMs?', 
 '["Recurrent Neural Networks", "Transformers", "Convolutional Neural Networks", "Generative Adversarial Networks"]', 
 1, 
 'Transformers, introduced in the "Attention Is All You Need" paper, form the architectural foundation of modern LLMs.'),

((SELECT id FROM lesson1), 'What mechanism allows LLMs to weigh the importance of different words in a sequence?', 
 '["Tokenization", "Embedding", "Self-Attention", "Pooling"]', 
 2, 
 'Self-Attention mechanisms allow models to weigh the importance of different words in relation to each other.'),

((SELECT id FROM lesson1), 'Which of the following is NOT a common LLM?', 
 '["GPT-4", "Claude", "ResNet", "Llama"]', 
 2, 
 'ResNet is a convolutional neural network architecture used primarily for computer vision tasks, not a language model.');

-- Insert challenges for Lesson 1
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson1), 'Explain how tokenization works in LLMs in one or two sentences.', 
 'Tokenization breaks text into smaller units (tokens) that can be processed by the model, converting words or subwords into numerical IDs that the model can understand.', 
 50);

-- Insert quizzes for Lesson 2
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson2), 'What year was the Transformer architecture introduced?', 
 '["2015", "2017", "2019", "2021"]', 
 1, 
 'The Transformer architecture was introduced in the 2017 paper "Attention Is All You Need" by Vaswani et al.'),

((SELECT id FROM lesson2), 'Which component enables Transformers to process sequences in parallel?', 
 '["Recurrent connections", "Self-attention mechanism", "Convolutional layers", "LSTM cells"]', 
 1, 
 'Self-attention allows transformers to process all tokens in parallel, unlike recurrent networks which process sequentially.'),

((SELECT id FROM lesson2), 'Why is positional encoding necessary in Transformer architectures?', 
 '["To increase the model''s vocabulary", "To enable gradient flow", "To provide information about token positions", "To compress the model size"]', 
 2, 
 'Since transformers process all tokens simultaneously rather than sequentially, positional encoding is needed to give the model information about the order of tokens.');

-- Insert challenges for Lesson 2
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson2), 'Compare and contrast the encoder and decoder components of a Transformer architecture.', 
 'The encoder processes the input sequence and creates representations, while the decoder generates output sequences. The encoder has self-attention to relate all input tokens to each other, while the decoder has masked self-attention (to prevent looking ahead) and cross-attention to focus on relevant encoder outputs.', 
 75);

-- Insert quizzes for Lesson 3
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson3), 'What is prompt engineering?', 
 '["Writing code to make models run faster", "Designing inputs to get optimal outputs from language models", "Creating new LLM architectures", "Optimizing hardware for AI workloads"]', 
 1, 
 'Prompt engineering is the process of crafting effective inputs to elicit the desired outputs from language models.'),

((SELECT id FROM lesson3), 'Which of the following is NOT a key principle of effective prompts?', 
 '["Clarity", "Context", "Complexity", "Format specification"]', 
 2, 
 'While clarity, context, and format specification are important principles, unnecessary complexity is generally avoided in effective prompting.'),

((SELECT id FROM lesson3), 'What is "role prompting" in the context of LLMs?', 
 '["Assigning different team members to write prompts", "Asking the model to assume a specific persona or role", "Rotating between different models", "Testing prompts with different parameters"]', 
 1, 
 'Role prompting involves instructing the model to assume a specific character, expert, or persona (e.g., "Act as a historian") to shape its responses.');

-- Insert challenges for Lesson 3
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson3), 'Write a prompt that would help an LLM generate a concise summary of a scientific paper.', 
 'Please analyze the following scientific paper and provide a concise summary that includes: 1) The main research question, 2) The methodology used, 3) Key findings, and 4) Implications or conclusions. Limit your summary to 3-4 paragraphs and focus on the most important aspects of the research.', 
 50);

-- Continue with more quizzes and challenges for other lessons
-- Quizzes for Lesson 4
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson4), 'What is chain-of-thought prompting?', 
 '["A method to link multiple LLMs together", "A technique that guides models to show step-by-step reasoning", "A way to optimize prompt length", "A method to reduce API costs"]', 
 1, 
 'Chain-of-thought prompting guides models to break down complex reasoning into step-by-step thinking, improving performance on tasks requiring multi-step reasoning.'),

((SELECT id FROM lesson4), 'Which approach involves generating multiple reasoning paths and taking a majority vote?', 
 '["Few-shot learning", "Self-consistency", "Meta-prompting", "Prefix optimization"]', 
 1, 
 'Self-consistency involves generating multiple reasoning paths for the same problem and taking a majority vote to improve accuracy.'),

((SELECT id FROM lesson4), 'What is ReAct in the context of prompting?', 
 '["Reactive programming for LLMs", "A technique to measure model reaction time", "A framework combining reasoning and action", "A method to test model reflexes"]', 
 2, 
 'ReAct (Reasoning + Action) is an approach that interleaves reasoning traces with task-specific actions to improve model performance.');

-- Insert challenges for Lesson 4
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson4), 'Create a chain-of-thought prompt for solving a complex math word problem.', 
 'I need to solve this math problem: "A store sells notebooks for $4 each and pens for $1.50 each. Emma spent $33 on supplies, buying at least one of each item. If she bought 12 items in total, how many notebooks did she buy?" To solve this step by step, I''ll work through the constraints systematically. Let x be the number of notebooks and y be the number of pens. I know that x + y = 12 (total items) and 4x + 1.5y = 33 (total cost). Since y = 12 - x, I can substitute: 4x + 1.5(12 - x) = 33. Simplifying: 4x + 18 - 1.5x = 33. This gives 2.5x + 18 = 33, so 2.5x = 15, and x = 6. Therefore, Emma bought 6 notebooks and 6 pens.', 
 100);

-- Quizzes for Lesson 5
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson5), 'What is the main purpose of fine-tuning an LLM?', 
 '["To reduce its size", "To make it run faster", "To adapt it for specific tasks or domains", "To encrypt its weights"]', 
 2, 
 'Fine-tuning adapts a pre-trained model to specialized tasks or domains, enhancing its performance on targeted applications.'),

((SELECT id FROM lesson5), 'Which of the following is a parameter-efficient fine-tuning method?', 
 '["Full gradient descent", "Data augmentation", "LoRA (Low-Rank Adaptation)", "Dropout regularization"]', 
 2, 
 'LoRA is a parameter-efficient fine-tuning method that adapts low-rank matrices rather than all model weights.'),

((SELECT id FROM lesson5), 'What does RLHF stand for?', 
 '["Recurrent Learning Hybrid Function", "Reinforcement Learning from Human Feedback", "Reduced Latency Hardware Framework", "Residual Learning High Fidelity"]', 
 1, 
 'RLHF stands for Reinforcement Learning from Human Feedback, a technique that uses human preferences to align model behavior.');

-- Insert challenges for Lesson 5
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson5), 'Explain the difference between full fine-tuning and parameter-efficient fine-tuning approaches like LoRA.', 
 'Full fine-tuning updates all model weights during training, which requires significant computational resources and storage for each fine-tuned model version. Parameter-efficient methods like LoRA instead freeze most weights and train small adapters or low-rank matrices that modify the model''s behavior with far fewer parameters (typically <1% of the original model size). This dramatically reduces memory requirements, enables faster training, and allows easier storage and switching between multiple specialized adaptations.', 
 75);

-- Quizzes for Lesson 6
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson6), 'Which of the following is NOT a common benchmark for evaluating LLMs?', 
 '["MMLU", "HELM", "ImageNet", "BigBench"]', 
 2, 
 'ImageNet is a benchmark for image classification tasks, not specifically for evaluating LLMs.'),

((SELECT id FROM lesson6), 'What is "LLM-as-Judge" in the context of evaluation?', 
 '["A legal framework for AI governance", "Using large language models to evaluate outputs of other models", "A certification program for AI ethics", "A method to determine if content was AI-generated"]', 
 1, 
 'LLM-as-Judge approaches use capable language models to evaluate the outputs of other models, providing scalable automated evaluation.'),

((SELECT id FROM lesson6), 'Which metric is most appropriate for evaluating the factual accuracy of an LLM?', 
 '["Perplexity", "BLEU score", "Fact-checking against reliable sources", "Token generation speed"]', 
 2, 
 'Fact-checking against reliable sources is the most appropriate method for evaluating factual accuracy, whereas perplexity and BLEU are more focused on fluency and translation quality.');

-- Insert challenges for Lesson 6
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson6), 'Design a simple evaluation framework for assessing an LLM''s performance on a customer service task.', 
 'My evaluation framework for LLMs in customer service would include: 1) Answer accuracy (correctly addressing the customer''s question), 2) Helpfulness (providing actionable information), 3) Tone appropriateness (professional, empathetic), 4) Conciseness (efficient but complete responses), and 5) Safety (avoiding harmful advice). Each dimension would be rated on a 1-5 scale by human evaluators using standardized questions. I would also include automated metrics like response time and a comparative evaluation where evaluators blindly choose between human and LLM responses. Finally, I would track customer satisfaction metrics when actually deployed.', 
 75);

-- Quizzes for Lesson 7
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
((SELECT id FROM lesson7), 'What are "hallucinations" in the context of LLMs?', 
 '["Visual artifacts in multimodal models", "When models generate false or misleading content confidently", "Emotional responses by models", "Hardware failures during inference"]', 
 1, 
 'Hallucinations occur when language models confidently generate content that is factually incorrect, fabricated, or misleading.'),

((SELECT id FROM lesson7), 'Which of the following is NOT an ethical concern specific to large language models?', 
 '["Bias and fairness", "Privacy of training data", "Hardware obsolescence", "Potential for generating misinformation"]', 
 2, 
 'While hardware obsolescence is a general technology concern, it is not an ethical issue specific to LLMs like bias, privacy, and misinformation are.'),

((SELECT id FROM lesson7), 'What is "red-teaming" in the context of LLM safety?', 
 '["Running models on specialized hardware", "Deliberately stress-testing models to find vulnerabilities", "Using models to detect malware", "Training competing models against each other"]', 
 1, 
 'Red-teaming involves deliberately testing models with adversarial inputs to identify potential vulnerabilities and safety issues.');

-- Insert challenges for Lesson 7
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
((SELECT id FROM lesson7), 'Identify and explain three specific measures that developers can implement to make LLMs more ethical and responsible.', 
 '1) Diverse and representative training data: Developers should ensure training data includes diverse perspectives and representations to minimize bias, with ongoing auditing to identify and address biases that emerge. 2) Transparent model documentation: Create detailed model cards that explain capabilities, limitations, intended uses, and potential risks, helping users make informed decisions about appropriate applications. 3) Tiered content filtering systems: Implement multi-layered safety systems that prevent harmful outputs while maintaining legitimate use cases, with specific protocols for sensitive domains like medical or legal advice that include appropriate disclaimers and confidence indicators.', 
 100);

-- Seed Data for LLMastery Database

-- Insert Lessons
INSERT INTO lessons (id, title, description, content, level, category, duration, points, xp_reward, order_index, is_published)
VALUES 
  ('00000000-0000-0000-0000-000000000001', 
   'Introduction to Large Language Models', 
   'Learn the basics of Large Language Models and how they are transforming AI.',
   '# Introduction to Large Language Models

## What are Large Language Models?

Large Language Models (LLMs) are advanced AI systems trained on vast amounts of text data. They can understand and generate human-like text, translate languages, write different kinds of creative content, and answer questions in an informative way.

## Key Concepts

### 1. Neural Networks
LLMs are built on neural networks, specifically transformer architectures, which allow them to process and generate text with remarkable fluency.

### 2. Training Data
These models learn from diverse text sources across the internet, books, articles, and other written content.

### 3. Parameters
The "large" in LLMs refers to the number of parameters (weights and biases) they contain, often in the billions or trillions.

### 4. Capabilities
Modern LLMs can:
- Generate coherent and contextually relevant text
- Answer questions and provide explanations
- Summarize lengthy documents
- Translate between languages
- Write creative content like stories or poems
- Code in various programming languages

## Applications of LLMs

LLMs are revolutionizing numerous fields:

- **Customer Service**: Powering intelligent chatbots
- **Content Creation**: Assisting with writing and editing
- **Education**: Personalized tutoring and explanations
- **Healthcare**: Summarizing medical research and records
- **Software Development**: Code generation and debugging assistance

## Limitations

Despite their impressive capabilities, LLMs have important limitations:
- May generate incorrect information confidently
- Limited knowledge cutoff based on training data
- Can exhibit biases present in training data
- No true understanding or consciousness

## The Future of LLMs

As technology advances, we can expect:
- More specialized models for specific domains
- Better reasoning capabilities
- Improved factual accuracy
- More efficient training and deployment methods

In the upcoming lessons, we will explore these concepts in greater depth and learn how to effectively work with LLMs.
',
   'beginner',
   'fundamentals',
   15,
   10,
   25,
   1,
   true),
   
  ('00000000-0000-0000-0000-000000000002', 
   'Prompting Techniques', 
   'Master the art of crafting effective prompts to get the best results from LLMs.',
   '# Prompting Techniques

## The Art and Science of Prompting

Prompting is the process of crafting input text to guide an LLM''s responses. Effective prompting is crucial for getting the most out of these powerful models.

## Basic Prompting Principles

### 1. Be Clear and Specific
The more specific your prompt, the more targeted the response will be.

**Example:**
- Vague: "Tell me about dogs."
- Specific: "Explain the key differences between Labradors and Golden Retrievers in terms of temperament, care needs, and common health issues."

### 2. Provide Context
Including relevant context helps the model understand what you''re looking for.

**Example:**
- Without context: "How do I fix this error?"
- With context: "I''m building a React application and getting this error: ''Cannot read property ''map'' of undefined''. How can I fix it?"

### 3. Structure Your Prompt
Breaking down complex requests into structured sections can improve results.

**Example:**
```
I need a business email to a client about project delays:
- Tone: Professional but apologetic
- Context: Software development project delayed by 2 weeks
- Key points: Technical challenges encountered, new timeline, compensatory measures
```

## Advanced Prompting Techniques

### 1. Chain of Thought Prompting
Ask the LLM to work through a problem step-by-step.

**Example:**
"Let''s solve this word problem step-by-step: If Lisa has 5 apples and buys 3 more, but gives 2 to her friend, how many apples does she have now?"

### 2. Role-Based Prompting
Assign a specific role or persona to the LLM.

**Example:**
"As an experienced cybersecurity expert, explain the implications of zero-day vulnerabilities to a non-technical board of directors."

### 3. Few-Shot Learning
Provide examples of the desired output format.

**Example:**
```
Convert these sentences to past tense:
1. I walk to the store. → I walked to the store.
2. She sings beautifully. → She sang beautifully.
3. They run every morning. → 
```

### 4. Refinement Iterations
Use multiple interactions to refine outputs.

1. Initial prompt: "Write a short story about time travel."
2. Refinement: "Make the story more suspenseful and set it in Victorian London."
3. Further refinement: "Add a twist ending that connects to the beginning."

## Common Pitfalls

- **Ambiguity**: Avoid vague language that could be interpreted in multiple ways
- **Overly Complex Requests**: Break down complex tasks into smaller, manageable prompts
- **Contradictory Instructions**: Ensure your prompt doesn''t contain conflicting guidance

## Practical Applications

- **Content Creation**: Generate outlines, drafts, or creative ideas
- **Problem-Solving**: Work through complex problems with guided reasoning
- **Learning**: Request explanations at varying levels of complexity
- **Code Generation**: Create code snippets with specific functionalities

In the next lesson, we''ll explore how to evaluate and improve LLM outputs for different use cases.
',
   'beginner',
   'techniques',
   20,
   15,
   30,
   2,
   true),
   
  ('00000000-0000-0000-0000-000000000003', 
   'Evaluating LLM Outputs', 
   'Learn how to critically assess and improve the quality of outputs from large language models.',
   '# Evaluating LLM Outputs

## Why Evaluation Matters

As powerful as LLMs are, their outputs require careful evaluation. Learning to assess LLM-generated content is a critical skill for effectively leveraging these tools while avoiding potential pitfalls.

## Evaluation Criteria

### 1. Factual Accuracy
Verify that the information provided is correct and up-to-date.

**Techniques:**
- Cross-reference with reliable sources
- Check for logical inconsistencies
- Be wary of confident-sounding but incorrect statements
- Consider the model''s knowledge cutoff date

### 2. Relevance
Assess whether the response directly addresses your query or needs.

**Questions to ask:**
- Does it answer the specific question posed?
- Does it cover all aspects of the query?
- Is there extraneous information that wasn''t requested?

### 3. Coherence and Fluency
Evaluate the logical flow and linguistic quality of the output.

**Look for:**
- Clear structure and organization
- Logical transitions between ideas
- Grammatical correctness
- Appropriate tone and style

### 4. Completeness
Determine if the response covers all necessary aspects of the topic.

**Consider:**
- Are there important omissions?
- Does it provide appropriate depth given the context?
- Are there perspectives or alternatives that should be mentioned?

### 5. Bias and Fairness
Check for unintended biases or one-sided presentations.

**Watch for:**
- Unbalanced treatment of controversial topics
- Stereotypical representations
- Unfair emphasis or de-emphasis of certain viewpoints

## Practical Evaluation Methods

### The "Traffic Light" System
A simple evaluation framework:
- 🟢 Green: Accept as is (high quality, accurate, complete)
- 🟡 Yellow: Usable with revisions (generally good but needs improvements)
- 🔴 Red: Reject and regenerate (serious issues with accuracy or quality)

### Expert Review
When working in specialized domains:
- Have subject matter experts review generated content
- Focus on technical accuracy and domain-specific conventions
- Check for proper use of terminology

### A/B Testing
For content with specific goals:
- Generate multiple variants
- Test their effectiveness for the intended purpose
- Refine based on performance metrics

## Improving LLM Outputs

### 1. Iterative Refinement
Use feedback loops to improve results:
- Identify specific issues with the initial output
- Request targeted improvements
- Repeat until satisfactory

### 2. Post-Processing
Apply systematic corrections to outputs:
- Fact-checking critical information
- Standardizing formatting and style
- Filling in gaps with additional research

### 3. Human-AI Collaboration
Blend human expertise with AI capabilities:
- Use LLM outputs as first drafts
- Apply human judgment for refinement
- Leverage complementary strengths

## Real-World Application

Consider this workflow for creating technical documentation:
1. Generate initial draft with an LLM
2. Evaluate for technical accuracy and completeness
3. Identify and correct any issues
4. Enhance with examples and clarifications
5. Final human review before publication

By developing strong evaluation skills, you can maximize the benefits of LLMs while mitigating their limitations.
',
   'beginner',
   'techniques',
   25,
   20,
   35,
   3,
   true),
   
  ('00000000-0000-0000-0000-000000000004', 
   'Fine-tuning LLMs', 
   'Understand how to adapt pre-trained models to specific domains and tasks.',
   '# Fine-tuning LLMs

## What is Fine-tuning?

Fine-tuning is the process of further training a pre-trained language model on a specific dataset to adapt it for particular tasks or domains. This process allows you to create more specialized models that excel at specific functions while leveraging the general knowledge and capabilities of the base model.

## When to Consider Fine-tuning

Fine-tuning is particularly valuable when:

- You need consistent output formats or styles
- Your application requires domain-specific knowledge
- You want to align the model with particular values or guidelines
- You need to improve performance on specialized tasks
- You require reduced latency for specific applications

## The Fine-tuning Process

### 1. Preparing Your Dataset

The quality of your fine-tuning dataset largely determines the quality of your fine-tuned model.

**Key considerations:**
- **Size**: Typically hundreds to thousands of examples
- **Quality**: High-quality, consistent examples
- **Diversity**: Representative of real-world use cases
- **Format**: Usually input-output pairs in a structured format

**Example dataset format:**
```json
[
  {
    "input": "Summarize the following medical research abstract: [abstract text]",
    "output": "This research investigated..."
  },
  {
    "input": "Summarize the following medical research abstract: [abstract text]",
    "output": "The study examined..."
  }
]
```

### 2. Selecting a Base Model

Choose an appropriate pre-trained model based on:

- Size and computational requirements
- Base capabilities
- Licensing terms
- Availability and support

### 3. Hyperparameter Selection

Fine-tuning requires setting several important hyperparameters:

- **Learning rate**: Typically much smaller than in pre-training
- **Number of epochs**: How many times to iterate through the dataset
- **Batch size**: Number of examples processed together
- **Optimizer settings**: Adam is commonly used

### 4. Training Infrastructure

Fine-tuning can be resource-intensive:

- GPU/TPU requirements vary by model size
- Cloud services offer specialized fine-tuning environments
- Smaller models may be fine-tuned on consumer hardware

### 5. Evaluation

Assess your fine-tuned model against:

- Hold-out test set performance
- Business metrics relevant to your application
- Baseline performance of the pre-trained model

## Fine-tuning Techniques

### Full Fine-tuning

Update all or most parameters in the model:
- Provides maximum adaptation
- Requires more data and computational resources
- Higher risk of catastrophic forgetting

### Parameter-Efficient Fine-tuning (PEFT)

Update only a small subset of parameters:
- **LoRA (Low-Rank Adaptation)**: Adds low-rank matrices to existing weights
- **Adapters**: Inserts small trainable modules between layers
- **Prompt Tuning**: Trains continuous prompt vectors

Benefits include:
- Much smaller storage requirements
- Reduced computational needs
- Easier to combine multiple adaptations

## Practical Considerations

### Ethical and Safety Guardrails

Fine-tuning can potentially remove safety guardrails from base models:
- Consider implementing additional safety filters
- Test extensively for harmful outputs
- Maintain oversight of the fine-tuning data

### Avoiding Overfitting

Signs of overfitting include:
- Perfect performance on training data but poor generalization
- Memorization of specific examples rather than learning patterns
- Degraded performance on general knowledge tasks

### Managing Expectations

Fine-tuned models:
- Won''t gain knowledge that wasn''t in the training data
- May still make mistakes in domain-specific outputs
- Require ongoing evaluation and potentially retraining

## Case Studies

### Domain-Specific Assistants

Fine-tuning for specialized fields like:
- Legal document analysis
- Medical diagnosis assistance
- Technical customer support

### Style and Format Adaptation

Fine-tuning to consistently produce:
- Brand-specific marketing copy
- Structured data extraction
- Code in specific styles or patterns

In the next lesson, we''ll explore how to deploy and integrate fine-tuned models into production systems.
',
   'intermediate',
   'techniques',
   30,
   30,
   50,
   4,
   true),
   
  ('00000000-0000-0000-0000-000000000005', 
   'Multimodal LLMs', 
   'Explore models that can process and generate content across text, images, and other modalities.',
   '# Multimodal LLMs

## Beyond Text: The Power of Multimodal AI

Multimodal Large Language Models (MLLMs) extend the capabilities of traditional LLMs by incorporating multiple types of data beyond just text. These advanced systems can process, understand, and generate content across different modalities, including images, audio, and potentially video.

## Key Capabilities

### 1. Visual Understanding

Multimodal LLMs can:
- Analyze and describe images in detail
- Answer questions about visual content
- Identify objects, scenes, text, and activities in images
- Understand charts, diagrams, and visual information

### 2. Text-to-Image Generation

Some multimodal systems can:
- Create images based on detailed text descriptions
- Modify existing images according to instructions
- Generate variations of visual content
- Create visual representations of concepts

### 3. Cross-modal Reasoning

Advanced capabilities include:
- Drawing connections between textual and visual information
- Using visual context to inform textual responses
- Explaining visual content with appropriate terminology
- Grounding language understanding in visual concepts

## Architecture and Design

### Vision Encoders

These components process visual inputs:
- Convolutional Neural Networks (CNNs) or Vision Transformers (ViT)
- Extract features from images at multiple levels of abstraction
- Convert visual information into vector representations

### Fusion Mechanisms

Methods for combining different modalities:
- **Early fusion**: Combining inputs before main processing
- **Late fusion**: Processing modalities separately and combining later
- **Cross-attention**: Allowing modalities to attend to each other
- **Joint embeddings**: Projecting different modalities into a shared space

### Training Approaches

Multimodal models typically use:
- Large datasets of aligned image-text pairs
- Contrastive learning objectives
- Masked prediction across modalities
- Instruction tuning with multimodal examples

## Popular Multimodal LLMs

Several groundbreaking models have emerged in this space:

- **GPT-4V**: Extends GPT-4 with visual input capabilities
- **Gemini**: Google's multimodal model with text, image, audio, and video capabilities
- **Claude 3**: Anthropic's model with image understanding
- **LLaVA**: An open source vision-language model

## Applications

### Content Creation

- Creating marketing materials with matching text and images
- Generating visual explainers for complex topics
- Designing mockups based on textual descriptions

### Accessibility

- Providing rich descriptions of images for visually impaired users
- Converting visual information to accessible formats
- Enhancing communication across sensory modalities

### Analysis and Insights

- Extracting information from documents with text and charts
- Analyzing product photos and reviews together
- Processing scientific papers with formulas, graphs, and text

### Education

- Creating visual explanations of difficult concepts
- Providing feedback on visual and textual assignments
- Developing rich, interactive learning materials

## Limitations and Challenges

### Hallucinations Across Modalities

- May "see" objects that aren't present
- Can misinterpret visual elements
- Might generate inconsistent descriptions

### Cultural and Contextual Understanding

- Varied interpretation of visual symbols across cultures
- Challenges with nuanced visual communication
- Potential biases in visual processing

### Technical Constraints

- Increased computational requirements
- More complex deployment needs
- Larger model sizes and memory usage

## Ethical Considerations

The multimodal nature introduces additional concerns:

- **Privacy**: Processing potentially sensitive visual data
- **Deepfakes**: More convincing synthetic content generation
- **Accessibility**: Ensuring equitable access across abilities
- **Representation**: Fair and unbiased visual processing

## The Future of Multimodal LLMs

We can anticipate developments in:

- More modalities (touch, smell, 3D environments)
- Richer integration between modalities
- More sophisticated reasoning across different types of input
- Specialized multimodal models for specific fields

In the next lesson, we will explore practical techniques for effectively working with multimodal LLMs.
',
   'intermediate',
   'advanced-concepts',
   35,
   35,
   55,
   5,
   true);

-- Insert more lessons as needed

-- Create the quiz questions for the lessons
INSERT INTO quizzes (lesson_id, question, options, correct_answer_index, explanation)
VALUES
  ('00000000-0000-0000-0000-000000000001', 
   'What is the primary architecture used in modern Large Language Models?', 
   ARRAY['Convolutional Neural Networks', 'Recurrent Neural Networks', 'Transformer Architecture', 'Generative Adversarial Networks'], 
   2, 
   'Modern Large Language Models primarily use the Transformer architecture, which was introduced in the paper "Attention is All You Need" and allows for parallel processing of text and better handling of long-range dependencies.'),
   
  ('00000000-0000-0000-0000-000000000001', 
   'What does the "large" in Large Language Models primarily refer to?', 
   ARRAY['The physical size of the computing infrastructure', 'The amount of text the model can generate', 'The number of parameters in the model', 'The size of the company that created it'], 
   2, 
   'The "large" in Large Language Models refers to the number of parameters (weights and biases) in the model, which can range from billions to trillions.'),
   
  ('00000000-0000-0000-0000-000000000001', 
   'Which of the following is NOT a common application of LLMs?', 
   ARRAY['Content creation', 'Translation between languages', 'Physical robot control without additional systems', 'Code generation'], 
   2, 
   'While LLMs excel at text-based tasks, they cannot directly control physical robots without additional systems and interfaces. The other options are common applications of LLMs.'),
   
  ('00000000-0000-0000-0000-000000000002', 
   'What is "chain of thought" prompting?', 
   ARRAY['Breaking a complex prompt into multiple separate prompts', 'Asking the LLM to work through a problem step-by-step', 'Linking multiple LLMs together', 'Creating a decision tree of potential responses'], 
   1, 
   'Chain of thought prompting involves asking the LLM to work through a problem step-by-step, showing its reasoning process. This technique often improves performance on complex reasoning tasks.'),
   
  ('00000000-0000-0000-0000-000000000002', 
   'Which of these is an example of good prompting practice?', 
   ARRAY['Keeping prompts as short as possible', 'Using vague language to allow creative interpretation', 'Providing relevant context and specific instructions', 'Asking multiple unrelated questions in one prompt'], 
   2, 
   'Providing relevant context and specific instructions is a good prompting practice as it helps the LLM understand exactly what you''re looking for and produce more useful results.'),
   
  ('00000000-0000-0000-0000-000000000003', 
   'Which of these is NOT typically a criterion for evaluating LLM outputs?', 
   ARRAY['Factual accuracy', 'Relevance to the query', 'Processing speed of generation', 'Coherence and fluency'], 
   2, 
   'While factual accuracy, relevance, and coherence are important evaluation criteria for LLM outputs, the processing speed of generation is more related to the model''s performance characteristics rather than output quality.'),
   
  ('00000000-0000-0000-0000-000000000003', 
   'What is the main purpose of the "Traffic Light" evaluation system mentioned in the lesson?', 
   ARRAY['To measure the reading level of the output', 'To categorize outputs for simple decision-making about their usability', 'To evaluate the emotional tone of responses', 'To count the number of factual errors'], 
   1, 
   'The Traffic Light system (green/yellow/red) provides a simple framework for categorizing outputs based on their quality and usability, helping users quickly decide whether to accept, revise, or reject the output.'),
   
  ('00000000-0000-0000-0000-000000000004', 
   'What is Parameter-Efficient Fine-tuning (PEFT)?', 
   ARRAY['Using as few parameters as possible in the base model', 'Updating only a small subset of model parameters during fine-tuning', 'Reducing the number of training examples needed', 'Pre-selecting the most important parameters before training'], 
   1, 
   'Parameter-Efficient Fine-tuning refers to techniques that update only a small subset of model parameters during fine-tuning, such as LoRA or adapters, which significantly reduces computational and storage requirements.'),
   
  ('00000000-0000-0000-0000-000000000004', 
   'What is a common sign of overfitting in a fine-tuned model?', 
   ARRAY['Poor performance on both training and test data', 'Perfect performance on training data but poor generalization to new examples', 'Consistent performance across all data types', 'Faster inference times than the base model'], 
   1, 
   'A key sign of overfitting is when a model performs extremely well on its training data but fails to generalize to new examples, indicating it has memorized the training data rather than learning the underlying patterns.'),
   
  ('00000000-0000-0000-0000-000000000005', 
   'Which of the following is NOT a common capability of multimodal LLMs?', 
   ARRAY['Describing the content of images', 'Answering questions about visual content', 'Physically manipulating objects based on visual input', 'Generating images from text descriptions'], 
   2, 
   'While multimodal LLMs can process and generate content across different modalities like text and images, they cannot physically manipulate objects in the real world, as this would require robotics and other physical systems.'),
   
  ('00000000-0000-0000-0000-000000000005', 
   'What is "late fusion" in the context of multimodal LLMs?', 
   ARRAY['Delaying the release of a model until all modalities are perfected', 'Processing different modalities separately and combining them at a later stage', 'Adding new modalities to an existing model after initial training', 'Introducing visual elements only at the end of text generation'], 
   1, 
   'Late fusion refers to an architectural approach where different modalities (like text and images) are processed separately through their respective encoders, and their representations are combined at a later stage in the model architecture.');

-- Insert challenges for each lesson
INSERT INTO challenges (lesson_id, prompt, example, point_value)
VALUES
  ('00000000-0000-0000-0000-000000000001', 
   'Explain in your own words what makes LLMs "large" and why this is significant for their capabilities.', 
   'Your explanation should include references to parameters, training data, and how scale contributes to emergent abilities.', 
   20),
   
  ('00000000-0000-0000-0000-000000000002', 
   'Create three different prompts for the same task using different prompting techniques discussed in the lesson.', 
   'Task example: Getting advice on improving a resume. Show basic prompting, role-based prompting, and chain-of-thought prompting approaches.', 
   25),
   
  ('00000000-0000-0000-0000-000000000003', 
   'Evaluate the following LLM output using the criteria discussed in the lesson and suggest specific improvements.', 
   'LLM output to evaluate: "The first airplane flight was conducted by Leonardo da Vinci in 1523 using a prototype he designed after studying birds. This historic achievement revolutionized transportation, though it would be centuries before commercial air travel became common."', 
   25),
   
  ('00000000-0000-0000-0000-000000000004', 
   'Design a fine-tuning dataset of 5 example pairs for teaching an LLM to summarize research papers in your field of interest.', 
   'For each example, provide an input (portion of a research paper) and the desired output (a structured summary). Explain why you structured your examples this way.', 
   30),
   
  ('00000000-0000-0000-0000-000000000005', 
   'Describe three potential applications of multimodal LLMs that could have significant real-world impact, and explain the ethical considerations for each.', 
   'Consider applications in healthcare, education, accessibility, or another domain of your choice. For each application, identify both benefits and potential risks.', 
   35);

-- Insert badges
INSERT INTO badges (id, name, description, image_url, criteria)
VALUES
  ('00000000-0000-0000-0000-000000000001', 
   'LLM Novice', 
   'Completed your first lesson on Large Language Models.', 
   '/badges/llm_novice.png', 
   'Complete one lesson'),
   
  ('00000000-0000-0000-0000-000000000002', 
   'Prompt Engineer', 
   'Mastered the art of creating effective prompts.', 
   '/badges/prompt_engineer.png', 
   'Complete the Prompting Techniques lesson with a perfect quiz score'),
   
  ('00000000-0000-0000-0000-000000000003', 
   'Critical Thinker', 
   'Demonstrated the ability to critically evaluate AI outputs.', 
   '/badges/critical_thinker.png', 
   'Complete the Evaluating LLM Outputs lesson and its challenge'),
   
  ('00000000-0000-0000-0000-000000000004', 
   'Fine-tuning Specialist', 
   'Gained expertise in adapting models to specific domains.', 
   '/badges/fine_tuning_specialist.png', 
   'Complete the Fine-tuning LLMs lesson and its challenge'),
   
  ('00000000-0000-0000-0000-000000000005', 
   'Multimodal Master', 
   'Explored the cutting edge of AI across multiple modalities.', 
   '/badges/multimodal_master.png', 
   'Complete the Multimodal LLMs lesson with a perfect quiz score');

-- Create functions for triggers

-- Function to create user profile after auth.user creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (user_id)
  VALUES (NEW.id);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create user profile
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to check and award badges
CREATE OR REPLACE FUNCTION check_and_award_badges()
RETURNS TRIGGER AS $$
DECLARE
  badge_id UUID;
BEGIN
  -- Check for LLM Novice badge (first lesson completed)
  IF NEW.completed = true AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id AND badge_id = '00000000-0000-0000-0000-000000000001'
  ) AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id
  ) THEN
    INSERT INTO user_badges (user_id, badge_id)
    VALUES (NEW.user_id, '00000000-0000-0000-0000-000000000001');
  END IF;
  
  -- Check for Prompt Engineer badge
  IF NEW.completed = true AND NEW.lesson_id = '00000000-0000-0000-0000-000000000002' 
     AND NEW.quiz_score = 100 AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id AND badge_id = '00000000-0000-0000-0000-000000000002'
  ) THEN
    INSERT INTO user_badges (user_id, badge_id)
    VALUES (NEW.user_id, '00000000-0000-0000-0000-000000000002');
  END IF;
  
  -- Check for Critical Thinker badge
  IF NEW.completed = true AND NEW.lesson_id = '00000000-0000-0000-0000-000000000003'
     AND NEW.challenge_completed = true AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id AND badge_id = '00000000-0000-0000-0000-000000000003'
  ) THEN
    INSERT INTO user_badges (user_id, badge_id)
    VALUES (NEW.user_id, '00000000-0000-0000-0000-000000000003');
  END IF;
  
  -- Check for Fine-tuning Specialist badge
  IF NEW.completed = true AND NEW.lesson_id = '00000000-0000-0000-0000-000000000004'
     AND NEW.challenge_completed = true AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id AND badge_id = '00000000-0000-0000-0000-000000000004'
  ) THEN
    INSERT INTO user_badges (user_id, badge_id)
    VALUES (NEW.user_id, '00000000-0000-0000-0000-000000000004');
  END IF;
  
  -- Check for Multimodal Master badge
  IF NEW.completed = true AND NEW.lesson_id = '00000000-0000-0000-0000-000000000005'
     AND NEW.quiz_score = 100 AND NOT EXISTS (
    SELECT 1 FROM user_badges 
    WHERE user_id = NEW.user_id AND badge_id = '00000000-0000-0000-0000-000000000005'
  ) THEN
    INSERT INTO user_badges (user_id, badge_id)
    VALUES (NEW.user_id, '00000000-0000-0000-0000-000000000005');
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;