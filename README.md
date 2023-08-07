# Prosodic-Rhythms-Analysis-Toolbox
The _Prosodic Rhythm Analysis Toolbox_ is a set of Matlab data, scripts, and functions devised to operate and visualize the relations between prosodic rhythm profiles inside the _rhythmesh_, a network made up of the set of all profiles. This research is based on the works of Leonard Meyer (1957), Cooper and Meyer (1968), and Fred Lerdahl (1983). It is linked to research in progress developed at the Federal University of Rio de Janeiro.

The basic concepts and fundamentals can be checked in detail in an article by Gentil-Nunes (2019), available at <[https://ppgm.musica.ufrj.br/formal-analysis-of-meyers-rhythmic-structures/](url)>.

Rhythmic profiles are classes of rhythmic groups, defined by a hierarchic relation between its elements. These classes are binary or ternary, and the elements can be a note or a subgroup (comprised by two or three notes). These constraints lead to a net of 296 profiles related by inclusion relations, or a _finite_ _poset_, forming what is called a _Hasse Diagram_ in the field of _order theory_. This specific net, formed by prosodic rhythmic profiles, is called _rhythmesh_ by Gentil-Nunes. We think that the study of this structure can bring some light on relations between different rhythmic features of musical gestures that are not accessible from the point of view of surface events.

To facilitate this task, we elaborate on the _Prosodic Rhythms Analysis Toolbox_ - a set of functions, scripts, and files for the exploration of the internal relations of the rhythmesh.

To run the toolbox, just download the files and add the folder to the Matlab path list. The instructions for each file are provided with the code.

The overall structure of the toolbox is composed of seven modules (Figure 1):
1. **Conversion** - translate any pcodes to the name of the profile, and vice-versa;
2. **Generation of pcodes list** - generates, beginning with the note (1), and parsing through each stratum, the complete list of 296 profiles of rhythmesh.
3. **Profile Properties** - provide, from a given profile, the chosen property. 
4. **Relations between profiles** - given two profiles, these functions return the quality of the adjacency relation or an empty set when there is no relation.
5. **Generation of tables** - these two functions generate the tables "profiles.mat" and "reltab.mat". The former is a list of the 296 profiles with all its properties. The latter is a list of all adjacency relations between chosen profiles (the selected profiles can be any subset of the rhythmesh or the overall set).
6. **Tables** - comprised of the tables "profiles.mat" and "reltab.mat". For the sake of simplicity, these two files are provided already rendered with the toolbox. This permits the function "perflab" to work out of the box.
7. **Graphs** - the script "perflab" is a showcase for generating graphs of subsets of the rhythmesh, using criteria extracted from the files "profiles.mat" and "reltab.mat". There are some preset suggestions, but the user can elaborate on any query that he wants.

|![PRA structure](https://github.com/Pauxygnunes/Prosodic-Rhythm-Analysis-Toolbox/assets/30673056/6e392dd3-a684-47dd-8a6a-986d15f81645)|
|:--:| 
| *Figure 1 - Overall structure of PRA Toolbox.* |

The resulting graphs show some substructures and relations that can be explored in musical analysis of musical composition (Figures 2, 3, and 4).

|![RP operations](https://github.com/Pauxygnunes/Prosodic-Rhythm-Analysis-Toolbox/assets/30673056/fdca217a-1643-413c-96ed-714d58bf02d9)|
|:--:| 
| *Figure 2 - Three examples of distribution of the 296 rhythmic profiles of rhythmesh into clusters based on two relations – prefixation (a) and prolation (b) – and the operation of rotation (c). Each rhythmic profile is represented by a point in the cluster.* |

|![BoiPreto_exemplo com árvores_v02](https://github.com/Pauxygnunes/Prosodic-Rhythm-Analysis-Toolbox/assets/30673056/7f75fd54-42dd-4206-bf56-26a91bbf4e0a)|
|:--:| 
| *Figure 3 - Boi Preto (Jongo da Serrinha, 2002): a) Score of the first phrase with lyrics; b) Rhythmic profiles notated in alphanumeric style (Gentil-Nunes, 2016, p. 159); c)  Rhythmic-formal structure presented in tree notation.* |

|![Boi Preto Level 3](https://github.com/Pauxygnunes/Prosodic-Rhythm-Analysis-Toolbox/assets/30673056/7b26cd19-0220-423b-863d-dc71d70bfb74)|
|:--:| 
| *Figure 4 - Boi Preto (Jongo da Serrinha, 2002): a) Rhythmic profiles connected by its inclusion relations; b) Section of the rhythmesh with the location of the former rhythmic profiles indicated by circled numbers.* |

The rhythmic codes that appear in the Figures are a system of symbols devised by Gentil-Nunes in his 2019 article to translate Meyer's rhythmic structures to character types. The intention is just to simplify the exchange and transmission of this kind of information (Figure 5).
|![Bruckner](https://github.com/Pauxygnunes/Prosodic-Rhythm-Analysis-Toolbox/assets/30673056/82a756d5-2aaa-402d-b3ae-82f91a4b603e)|
|:--:|
| *Bruckner, Symphony No. 9 (excerpt): analysis of Meyer’s rhythmic profiles in Meyerian notation (a), numerical notation (b), and alphanumeric notation (c). Item (a) adapted from Cooper and Meyer (1963, p. 95). Items (b), and (c), original conception by the present author* |

