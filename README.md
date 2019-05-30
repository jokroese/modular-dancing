# Modular dancing

Modular dancing is a system for creating rule-based modular choreography.

## Quickstart

1. Download [Processing](https://processing.org/download/).

2. Import oscP5

Open processing. Sketch > Import Library > Add Library. Then type in 'oscP5' in 'Libraries'. Click 'Install'.

3. Download (or clone) this repository.

### For the director
   
4. Open 'master/master.pde'.

5. Run.

### For dancers

4. Open 'receiver/receiver.pde'.

5. Edit which dancer you are. e.g. Dancer 3 will change the line to `int dancer_number = 3;`

6. Run.

#### To practice

If a dancer would like to practice their choreography by themself, they can run both the master and receiver file.

## What's in this repository

### Master file

Runs Game of Life simulation. Sends out OSC messages

### Receiver file

Receives messages and gives each dancer the notation for the choreography.