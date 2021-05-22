# Assignment 5 - (Un)supervised machine learning
**Christoffer Kramer**  
**29-03-2021**  
Train an LDA model on your data to extract structured information that can provide insight into your data. For example, maybe you are interested in seeing how different authors cluster together or how concepts change over time in this dataset.  

You should formulate a short research statement explaining why you have chosen this dataset and what you hope to investigate. This only needs to be a paragraph or two long and should be included as a README file along with the code. E.g.: I chose this dataset because I am interested in... I wanted to see if it was possible to predict X for this corpus
In this case, your peer reviewer will not just be looking to the quality of your code. Instead, they'll also consider the whole project including choice of data, methods, and output. Think about how you want your output to look. Should there be visualizations? CSVs?
You should also include a couple of paragraphs in the README on the results, so that a reader can make sense of it all. E.g.: I wanted to study if it was possible to predict X. The most successful model I trained had a weighted accuracy of 0.6, implying that it is not possible to predict X from the text content alone. And so on.  

## Research
I'm going to investigate which topics Redditors were discussing during the GameStop short squeeze, where Redditors on the subreddit r/Wallstreetbets collectively invested in GameStop stocks to bankrupt hedge funds. Because of hardware limitations, I'm only going to be looking at the period where the stock prices were most volatile (the 10th of January 2021 - the 17th of February 2021).  

_Research question:_ What topics of discussion dominated r/WallStreetBets during the GameStop short squeeze?  

### Data
I'm using a data set containing all reddit posts and comments from the subreddit r/WallStreetBets. The csv-file is BIG (209 MB), so I'm choosing a limited time window. 
I found the data set on kaggle here: https://www.kaggle.com/unanimad/reddit-rwallstreetbets

## Methods
This script uses Latent Dirichlet Allocation (LDA) to find topics in a collection of documents (in this case Reddit posts). This method assigns clusters of words to a given topic. Using these clusters of words, it then evaluates what topics (and their prevalence) each document consists of.  

## Running the script
You should be aware, that it might take a long time to run the script (up to an hour). The subreddit was extremely active during this period.  
This should work on both Linux, Mac, and Windows. However, if you are running on a local windows machine, you should run it from a bash emulator such as git bash.  

**Step 1 - Clone repo:**  
- open terminal  
- Navigate to destination for repo  
- type the following command  
```console
git clone https://github.com/Chris-Kramer/lang101_assignment_5.git
```  
**Step 2 - Navigate to assignment folder:**  
- Navigate to the folder "lang101_assignment_5".  
```console
cd lang101_assignment_5
```  
**Step 3 - Run bash script:**  
- Use the bash script _run_script-lda_reddit.sh_ to set up environment, unzip the csv-file, and run the script:  
```console
bash run_script-lda_reddit.sh
```  
### Running on windows without a bash emulator  
If you're running on a local window machine, and don't have a bash emulator, you must set up a virtual environment, activate it, upgrade pip, install dependencies (requirements.txt), unzip the file “r_wallstreetbets_posts.csv.zip”, and then run the python script manually from the src folder.  

### Output
The bash scripts will save an HTML file with a dashboard of topics, a plot that shows how well the models performs based on number of topics, a CSV file with keywords related to each topic, and a chart that shows how the topics have changed over time (5 days rolling average). All files are located in the folder "output".

## Parameters
The script takes the following parameters, it has already ben supplied with default values, but feel free to change them.
- `--start_date` Get posts from after this date. The input is a list with the following format YYYY M D  
    - Default: 2021 1 10  
- `--end_date` Exclude posts from after this date. The input is a list with the following format YYYY M D  
    - Default: 2021 2 17  
- `--rolling_avg` The rolling average that is used for plotting. The value represents days.
    - Default: 5  
- `--topics` the number of topics you wish to have in the model  
    - Default: 3  
- `--test_limit` The max amount of topics the model should test coherence scores for.
    - Default: 10  
  
### Example:  
_With bash script:_  
```console
bash run_script-lda_reddit.sh --start_date 2020 12 1 --end_date 2021 2 17 --rolling_avg 10 --topics 6
```  
_Without bash script:_  
```console
python lda_reddit.py --start_date 2020 12 1 --end_date 2021 2 17 --rolling_avg 10 --topics 6
```  

### Conclusion / Discussion
My analysis is only preliminary. However, from a purely computational and statistical point of view, my model preformed better (lower perplexity and higher coherence) when I had 4 topics, however from a human readability perspective the topics seemed more coherent and understandable when using 3 topics. When I had more than 3 topics, my model tended to cluster a few very dominant topics together and then have a lot of topics which only made up a fraction of the overall topics.  
This clustering made me worry that my model made mistakes, however after looking at the pyLDAvis board I realised, that the dominant topics where exlusively related to gamestop stocks and the gamestop saga, while the less prominent topics, where related to the gamestop saga AND a few other stocks. This indicates that the gamestop saga was so dominant, that it essentially created a hegemonic discourse.  
When looking at the three topics it is clear, that topic 0 and 1 are related to gamestop and buying stocks, while topic 2 (which is more or less non-existing until the 8th of february) also relates to other stocks. It is also interesting to note that topic 2 contains a lot of words related to mariuanna (weed, pot, cannabis etc.). This indicates that the redditors gained interest in stocks related to mariuanna, once the gamestop stocks started to lose their value. 