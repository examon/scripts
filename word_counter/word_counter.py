from collections import Counter
from sys import argv
from string import letters

# Count word frequency in text
# python word_counter.py file1 file2 fileN

words = []

if len(argv) > 1:
    for arg in argv[1:]:
        with open(arg, "r") as text:
            for line in text:
                chopped_line = line.split()
                for word in chopped_line:
                    # count only words starting/ending with letters
                    if word[0] not in letters or word[-1] not in letters:
                        continue
                    else:
                        words.append(word)

for word in Counter(words).most_common():
    print "%s: %d" % (word[0], word[1])
