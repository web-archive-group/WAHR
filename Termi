# Setting up Termite Visualizations on OS X

## Step One: Setting up Termite Data Server
Adapted from [https://github.com/uwdata/termite-data-server](https://github.com/uwdata/termite-data-server).
###Clone termite-data-server

In the directory where you want to use Termite, use:
`git clone https://github.com/uwdata/termite-data-server.git`

*Note that all of the following commands should be executed at the root of the repository (/termite-data-server/) unless otherwise noted.*

###Preparations

Run the following commands to prepare the necessary tools:

	bin/setup_corenlp.sh
	bin/setup_mallet.sh
	make -C utils/corenlp

It is also recommended to run the following:

	cd utils/corenlp
	make clean all
	cd ../../

###Additional Functions

Move the file *start_server_nogui.sh* to the root of the repository. Move the files *prepare_corpus.py* and *process_file.sh* to /bin/ .

## Step Two: Adding a Corpus to Termite
To create a new corpus in Termite using a plaintext (.txt) file it is only necessary to run *process_file.sh*. Note that each line in the text file will be treated as a separate document in the corpus. An example usage of *process_file.sh*:

`./bin/process_file.sh "The Corpus" ~/Desktop/thecorpus.txt`

*process_file.sh* takes three arguments: the name of the corpus, the location of the text file that the corpus will be made from, and (optional) a directory for temporary output. If no directory for output is specified, `/data/[corpus_name]/` will be used. The output directory can be safely deleted once the corpus is added to Termite.

## Step Three: Using Termite
Simply run `./bin/start_server_nogui.sh` to start the Termite server. It will ask you to set a password for the server. It will then be accessible at `http://127.0.0.1:8075`.

## Notes

### Functions in /bin/
- prepare_corpus.py => Accepts a raw .txt file and a location to create a directory for output (this directory must have a subdirectory /corpus/). Produces a properly formatted *corpus.txt* file and a blank *corpus.db* file in /corpus/.
- import_corpus.py => Accepts a *corpus.txt* file and the directory of a blank *corpus.db* file. Sets up the database based on the corpus.txt file.
- train_mallet.py => Accepts a *corpus.txt* file and a location to create a directory for output. Creates the output directory and prepares the necessary MALLET data from the *corpus.txt* file.
- read_mallet.py => Accepts a corpus name, the directory of MALLET data, the directory of a *corpus.txt* file, and the directory of a *corpus.db* file. Imports the corpus into the Termite data server.

### process_file.sh Step-By-Step

`./bin/process_file.sh "Test Corpus" ~/Desktop/test.txt ~/Desktop/data`

1. Creates `~/Desktop/data`, if it does not exist.
2. All tabs (\t) are removed from *test.txt*. Zero-padded line numbers are added.
3. Creates `/data/corpus/corpus.txt` and a blank `/data/corpus/corpus.db`.
4. Necessary database preparations are performed in `/data/corpus/`.
5. MALLET data from *corpus.txt* is prepared in `/data/model-mallet/`.
6. The MALLET data, *corpus.txt*, and *corpus.db* are read into Termite and added as a new corpus.
