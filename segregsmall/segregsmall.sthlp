{smcl}
{* *! version 1.1.0 28aug2019}{...}
{viewerjumpto "Syntax" "segregsmall##syntax"}{...}
{viewerjumpto "Description" "segregsmall##description"}{...}
{viewerjumpto "Options" "segregsmall##options"}{...}
{viewerjumpto "Remarks" "segregsmall##remarks"}{...}
{viewerjumpto "Examples" "segregsmall##examples"}{...}
{viewerjumpto "Stored results" "segregsmall##results"}{...}
{viewerjumpto "References" "segregsmall##references"}{...}
{viewerjumpto "Authors" "segregsmall##authors"}{...}
{viewerjumpto "Also see" "segregsmall##alsosee"}{...}
{cmd:help segregsmall}{right: ({browse "https://doi.org/10.1177/1536867X211000018":SJ21-1: st0631})}
{hline}

{title:Title}

{p2colset 5 20 22 2}{...}
{p2col:{cmd:segregsmall} {hline 2}}Estimation of segregation indices in small-unit settings{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:segregsmall}
{varlist}
{ifin}{cmd:,}
{opt f:ormat}{cmd:(}{it:format}{cmd:)}
{opt m:ethod}{cmd:(}{it:method}{cmd:)}
[{it:options}]

{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {opt f:ormat(format)}}indicate dataset's format; {it:format}
must be either {cmd:unit} or {cmd:indiv}{p_end}
{p2coldent:* {opt m:ethod(method)}}specify the method used to compute indices;
{it:method} must be {cmd:np}, {cmd:beta}, or {cmd:ct}{p_end}
{synopt :{opt condi:tional(conditional)}}perform conditional segregation
analysis; {it:conditional} must be either {cmd:unit} or {cmd:indiv} depending on the level of the characteristics{p_end}
{synopt :{opt with:single}}include in the analysis units with only one individual; by default, they are dropped as uninformative about segregation{p_end}
{synopt :{opt exclu:dingsinglepertype}}exclude from the analysis cells (unit x type) with only one individual; by default, they are included; available only in conditional analysis with individual characteristics{p_end}
{synopt :{opt indep:endencekp}}assume independence between units' sizes and the probabilities, within each unit, an individual belongs to the minority or reference group{p_end}
{synopt :{opt repb:ootstrap(#)}}set the number of bootstrap iterations for inference; default is {cmd:repbootstrap(200)}{p_end}
{synopt :{opt l:evel(#)}}set level in (0,1) for additional confidence
intervals (CIs); by default, usual 0.9, 0.95, and 0.99 CIs are saved{p_end}
{synopt :{opt noci}}restrict the command to estimation (no CIs){p_end}
{synopt :{opt testb:inomial}}perform a test of the binomial assumption that
underlies the statistical model; in {cmd:method(np)}, it is done by default with inference{p_end}
{synopt :{opt repct(#)}}set the number of repetitions used to compute random
allocation in {cmd:method(ct)}; default is {cmd:repct(50)}{p_end}
{synopt :{opt atkinson(#)}}set the parameter (often denoted "b" or "beta") for the Atkinson index; default and recommended is {cmd:atkinson(0.5)}{p_end}
{synoptline}
{p2colreset}{...}
{pstd}
* {cmd:format()} and {cmd:method()} are required.


{marker description}{...}
{title:Description}

{pstd}
{cmd:segregsmall} estimates classical indices (Duncan, Theil, Atkinson,
Coworker, and Gini) to measure segregation, namely, the systematic relative
concentration of a minority group (for example, foreigners) in some units
only.  Units can be, for instance, firms, neighborhoods, geographical areas,
or classrooms.

{pstd}
Three methods can be used: {cmd:np} for D'Haultf{c 0x9c}uille and Rathelot
(2017), {cmd:beta} for Rathelot (2012), and {cmd:ct} for Carrington and Troske
(1997).  Those methods deal with the small-unit bias (overestimation of
segregation in settings where units are small, that is, composed of few
individuals).  With {cmd:method(np)} and {cmd:method(beta)}, inference on the
segregation indices can be done by bootstrap.

{pstd}
Conditional segregation indices can be computed: they measure "net" or
"residual" segregation, accounting for other characteristics (either of
individuals or of units) that may influence the allocation of individuals into
units.


{marker options}{...}
{title:Options}

{phang}
{opt format(format)} indicates the format of the dataset used and needs to be
either {cmd:unit} (datasets where an observation is a unit) or {cmd:indiv}
(datasets where an observation is an individual).  {cmd:format()} is required.
The option determines the variables to be put in {it:varlist}.  For
unconditional analyses (the default without the option {cmd:conditional()}),
these are the following:

{pmore}
{varlist} needs to be {cmd:K X} for unit-level datasets: an observation is a
unit, the variable {cmd:K} is the number of individuals, and the variable
{cmd:X} is the number of minority individuals in the unit.  The values of
{cmd:K} (respectively, {cmd:X}) need to be positive (respectively, positive or
null) integers; for each unit, {cmd:X} must be lower or equal to {cmd:K}.

{pmore}
{varlist} needs to be {cmd:id_unit I_minority} for individual-level datasets:
an observation is an individual, the variable {cmd:id_unit} is the identifier
of the unit, the variable {cmd:I_minority} has to be a dummy variable equal to
1 if the individual belongs to the minority group and 0 otherwise.

{phang}
{opt method(method)} specifies the method used to compute the segregation
indices.  {it:method} must be one of {cmd:np}, {cmd:beta}, or {cmd:ct}.
{cmd:method()} is required.  {cmd:np} and {cmd:beta} methods, for a given
index, say, the Duncan, estimate the same parameter of interest.  The latter,
a segregation index, is defined as a function of the distribution of a random
variable p.  Each unit has a realization of that random variable, which is the
probability that an arbitrary individual within the unit belongs to the
minority group.  The main assumptions regarding data-generating processes that
enable identification, estimation, and inference are the following: i) the
units are independent and identically distributed; ii) for each unit, we
assume that conditional on the realization of p and the unit's size K, the
number of minority individuals X is distributed according to a binomial(K, p).
The parameter of interest estimated by {cmd:method(ct)} is different.  In this
case, the index is defined as an inequality index on the list, across units,
of the empirical proportion X/K of minority individuals.

{phang2}
{cmd:np} stands for nonparametric and implements the method of 
D'Haultf{c 0x9c}uille and Rathelot (2017).  In short, the distribution of p is
not restricted with that method.  {cmd:method(np)} allows one to estimate and
make inference on four classical segregation indices: Duncan (also known as
dissimilarity), Theil, Atkinson, and Coworker (also known as isolation).

{phang2}
{cmd:beta} implements the method of Rathelot (2012).  The method assumes a
Beta distribution for the random variable p, hence its name.
{cmd:method(beta)} allows one to estimate and make inference on the four
previous segregation indices plus the Gini index.

{phang2}
{cmd:ct} implements the method of Carrington and Troske (1997).  The basic
idea of the method is to correct the direct index obtained as an inequality
index on the proportion X/K across units.  The more variation in the
proportion X/K across units, the higher the index.  Yet, because of small-unit
considerations, the lower the unit size K, the more variation.  Hence, a
second step is needed that consists in a correction of the index obtained.
The correction is made by comparing the actual value of the inequality index
in data with the expected value of the index when individuals are allocated
randomly into units, keeping the structure fixed, namely, the units and their
sizes.

{phang}
{opt conditional(conditional)} estimates conditional segregation indices.  In
a nutshell, conditional segregation indices aim at measuring the relative
concentration of minority individuals in some units, accounting only for
characteristics that may influence the allocation of individuals into units.
The analogy can be made with linear models in which covariates are introduced
to account for the variance of the outcome variable.  The idea of conditional
segregation analysis is to compute indices that reflect the residual or net
level of segregation, while the contribution of covariates to segregation is
removed.  Covariates can be defined at the unit level or at the finer level of
a position or an individual.  Consider, for instance, firm segregation with
firms as units and foreigners as minority individuals.  A unit-level
characteristic can be the sector of the firm, whereas an individual-level
characteristic can be skilled or unskilled position or worker.
{it:conditional} must be either {cmd:unit} or {cmd:indiv}.  The choice depends
on the level at which the characteristics considered in the conditional
analysis are defined.

{pmore}
With unit-level covariates, {varlist} needs to be {cmd:K X Z} for unit-level
datasets or {cmd:id_unit I_minority Z} for individual-level datasets.  The
additional Z is a categorical variable that indicates the type of each unit.
Z needs to take values in 1, 2, 3, ....  It can be constructed from a natural
discrete variable, quantiles of a continuous characteristic, or intersections
of various features of units.

{pmore}
With individual-level (or position-level) covariates, individual-level
datasets are necessary, and {varlist} needs to be {cmd:id_unit I_minority W}.
The additional W is a categorical variable that indicates the type of each
individual.  W needs to take values in 1, 2, 3, ....  Again, it can be defined
from one discrete variable, quantiles of a continuous attribute, or
intersections of various characteristics defined at the individual or position
level.

{pmore}
In both cases, the aggregated conditional index is defined and estimated as a
convex combination of indices restricted to each type.  For unit-level
covariates, we consider the different subsamples of units defined by type Z =
z.  For individual-level covariates, we consider the different subsamples of
individuals defined by type W = w.  Note that, in the latter case, the
small-unit bias is compounded.  Indeed, units are divided into cells that are
defined as an intersection of a unit and an individual type.

{phang}
{opt withsingle} forces to include the units with only one individual in the
analysis.  By default, single units, that is, with only one individual, are
excluded from the analysis.  Indeed, they are uninformative about segregation
because the empirical proportion of minority individuals for such units is
either 0 or 1, that is, the range of possible values for the empirical
proportion and for the underlying probability p.  The option is available both
for unconditional or conditional analyses, either at individual or unit level.

{phang}
{opt excludingsinglepertype} is available only for conditional analyses with
individual-level covariates.  In this case, an index is computed for each type
W = w on the subsample of individuals with type w.  Within this subsample, a
"unit" (as in the unconditional case) corresponds to a cell defined as the
intersection of a unit and an individual type.  Even if single units are
excluded at the start, some of the cells can be composed of only one
individual (it will be all the more frequent because the number of individual
types is large and the units' sizes are small) and thus would be uninformative
as regards segregation.  They are included by default in the analysis, but the
option enables to exclude them.

{phang}
{opt independencekp} assumes independence between the unit size K and the
probability p that an arbitrary individual in a unit belongs to the minority.
In {cmd:method(ct)}, following the original method, the issue of possible
dependencies between K and p is not addressed because the object p is not
considered: indices are based on the proportion X/K.  Therefore, the option is
irrelevant and not available with method {cmd:method(ct)}.  In
{cmd:method(np)} and {cmd:method(beta)}, by default, the links between those
two random variables are left unrestricted.  Hence, each method first computes
one index by unit size and then aggregates them into the final segregation
index.  The option forces independence between K and p and enables one to
perform estimation in a single step, gathering units of all sizes.  The
independence between K and p is an assumption and should be used only when
reliable.

{phang}
{opt repbootstrap(#)} specifies the number of bootstrap repetitions used to
compute asymptotic CIs for methods {cmd:method(np)} and {cmd:method(beta)}.
Following the original article, CIs are not available for method
{cmd:method(ct)}.  The default is {cmd:repbootstrap(200)}.  The CIs reported
are for the different segregation indices.

{phang}
{opt level(#)} sets a personalized level in (0,1) for CIs with
{cmd:method(np)} and {cmd:method(beta)} and sets the personalized percentile
of the segregation indices computed under random allocation with
{cmd:method(ct)}.  {cmd:method(np)} and {cmd:method(beta)}: By default
(compare {it:Stored results}), CIs at the usual 90%, 95%, and 99% level are
computed and saved, and the 95% level CI is displayed in the log.  With the
option, the latter three CIs are still computed and stored, but an additional
CI at the specified level is computed, saved, and the one displayed in the
log.  Note that computing and saving several CIs is negligible as regards
computation time compared with the bootstrap procedure.  {cmd:method(ct)}: By
default (compare {it:Stored results}), the 1%, 5%, 10%, 90%, 95%, and 99%
empirical percentiles of the {opt repct(#)} draws of indices under random
allocation are reported.  The higher percentiles enable one to test the null
hypothesis that the data are consistent with random allocation (by comparing
the proportion-based index obtained in the data and the relevant quantiles).
With the option, the command also saves the 1-{opt level(#)}th and 
{opt level(#)}th empirical quantiles to perform the randomization test at a
specified level.

{phang}
{opt noci} restricts the command to estimation: only estimation is performed
and no CIs are reported.  The option is motivated by the computational cost of
inference by bootstrap, which can be substantial when the units' sizes are
large (above approximately 30 or 40 individuals), especially with
{cmd:method(np)}.  Besides, because of the construction of conditional
aggregated indices, the computational cost is globally multiplied by the
number of types included in the conditional analysis.

{phang}
{opt testbinomial} enables one to test the main hypothesis of the model for
the theoretical guarantees of {cmd:method(np)} and {cmd:method(beta)}, namely,
that, for each unit, conditional on the realization of p and the unit's size
K, the number of minority individuals X is distributed according to a
binomial(K, p).  The test relies on the techniques of {cmd:method(np)} when
the links between K and p are left unrestricted.  It uses the same bootstrap
procedure.  The option is available only for the unconditional case.  In
conditional analysis, the test can be performed separately for each type using
restrictions through the {cmd:if} and {cmd:in} qualifiers.

{pmore}
Consequently, with {cmd:method(np)} and inference without the option
{cmd:independencekp}, the test of the binomial assumption is made by default
because the additional computation cost is negligible.  It is stored (compare
{it:Stored results}) but not shown in the log by default.  In this case, the
option displays only the result of the test.

{pmore}
On the contrary, for any other configurations (with other methods, without
inference, with assumption of independence between K and p), in addition to
estimation (and possible inference), the option performs the test relying on
{cmd:method(np)}.

{pmore}
In both cases, the number of bootstrap repetitions used for the test is the
same as the one specified by the option {opt repbootstrap()}.  Although
possible, it is not recommended to use the option outside {cmd:method(np)} and
with inference.  Indeed, at the same cost, in addition to the test, the user
could get the estimated segregation indices by {cmd:method(np)}.

{phang}
{opt repct(#)} sets the number of repetitions (draws) used in the
{cmd:method(ct)} to compute the expected value of the index under random
allocation of individuals in units.  The default is {cmd:repct(50)}.  It might
seem low, but it happens that, empirically in many settings, many repetitions
lead to very similar estimates but at a higher computational cost.

{phang}
{opt atkinson(#)} sets the parameter for the Atkinson index.  Compared with
the other four classical indices considered (Duncan, Theil, Coworker, Gini),
the Atkinson index is parameterized by a value in (0,1), often denoted "b" or
"beta" in the segregation or income inequality literatures in which that index
is used.  The default is {cmd:atkinson(0.5)}.  Although the option allows one
to specify another parameter, it is not recommended because the default value
is the only one that ensures a desirable property of the Atkinson segregation
index, namely, symmetry.  That property says that relabeling the two groups
does not change the measure of segregation.


{marker remarks}{...}
{title:Remarks}

{pstd}
Previous descriptions and options provide the basic information required to
use {cmd:segregsmall} command.  However, we strongly encourage users to read
the three articles (compare {it:References}) that define the methods
implemented by the command for in-depth understanding.


{marker examples}{...}
{title:Examples}

{pstd}
Compute unconditional segregation indices using {cmd:method(np)}; inference is
done by boostrap using default 200 bootstrap iterations; dataset used is at
unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(np)}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(beta)}; inference
is done by boostrap using 150 bootstrap iterations; independence is assumed
between K and p; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(beta) independencekp repbootstrap(150)}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(ct)}; the CT
correction is done using default 50 repetitions; dataset used is at
unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(ct)}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(ct)}; the CT
correction is done using 100 repetitions; dataset used is at unit-level
format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(ct) repct(100)}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(beta)}, without
inference (only estimation), including single units (with one individual) in
the analysis; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(beta) withsingle noci}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(np)}, and
display in the output the result of the test of the binomial assumption;
inference is done by boostrap using default 200 bootstrap iterations that are
also used to do the test; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(np) testbinomial}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(beta)}; compute,
save, and display in the output CI at 99%; inference is done by boostrap using
500 bootstrap iterations; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X, format(unit) method(beta) repbootstrap(500) level(0.99)}{p_end}

{pstd}
Compute conditional segregation indices using {cmd:method(np)} with
unit-level covariates; inference is done by boostrap using default 200
bootstrap iterations; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X Z, format(unit) method(np) conditional(unit)}{p_end}

{pstd}
Compute conditional segregation indices using {cmd:method(beta)} with
unit-level covariates, without inference (only estimation), including single
units (with one individual) in the analysis; independence is assumed between K
and p; dataset used is at unit-level format{p_end}
{phang2}{cmd:. segregsmall K X Z, format(unit) method(beta) conditional(unit) withsingle noci independencekp}{p_end}

{pstd}
Compute unconditional segregation indices using {cmd:method(np)}; inference is
done by boostrap using default 200 bootstrap iterations; dataset used is at
individual-level format{p_end}
{phang2}{cmd:. segregsmall id_unit I_minority, format(indiv) method(np)}{p_end}

{pstd}
Compute conditional segregation indices using {cmd:method(beta)} with
individual-level covariates; inference is done by boostrap using default 200
bootstrap iterations, including single units (with one individual) in the
analysis; dataset used is at individual-level format{p_end}
{phang2}{cmd:. segregsmall id_unit I_minority W, format(indiv) method(beta) conditional(indiv) withsingle}{p_end}

{pstd}
Compute conditional segregation indices using {cmd:method(np)} with
individual-level covariates, without inference (only estimation), excluding
cells (unit x type) with only one individual from the analysis; independence
is assumed between K and p; dataset used is at individual-level format{p_end}
{phang2}{cmd:. segregsmall id_unit I_minority W, format(indiv) method(np) conditional(indiv) excludingsinglepertype independencekp}{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
The object stored in {cmd:e()} by {cmd:segregsmall} depends on the options,
notably, {opt conditional()}, but not only.  The following presentation
gathers the stored objects according to the type of information they convey
(relative to the data used in the analysis, relative to the method used,
relative to the results of the estimation and inference made) and according to
the specified options.

{pstd}Information relative to the data used:{p_end}

{pstd}Unconditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(I_withsingle)}}dummy for the use of option {opt withsingle}{p_end}
{synopt:{cmd:e(nb_units_total)}}number of units in the dataset used, including single units{p_end}
{synopt:{cmd:e(nb_units_single)}}number of units with only one individual in
the dataset used{p_end}
{synopt:{cmd:e(nb_units_studied)}}number of units included in the analysis, depending on option {opt withsingle} (it corresponds to the number of observations){p_end}
{synopt:{cmd:e(nb_individuals)}}number of individuals included in the analysis
(that is, within the units included in the analysis){p_end}
{synopt:{cmd:e(nb_minority_individuals)}}number of minority (or reference) individuals included in the analysis{p_end}
{synopt:{cmd:e(prop_minority_hat)}}estimated proportion of minority (or
reference) group (equal to
{cmd:e(nb_minority_individuals)}/{cmd:e(nb_individuals)}){p_end}
{synopt:{cmd:e(K_max)}}maximal size, that is, number of individuals K in a unit across the units included in the analysis{p_end}
{synopt:{cmd:e(nb_K_with_obs)}}number of distinct unique unit sizes present across the units included in the analysis{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(list_K_with_obs)}}list of the unique unit sizes present across the units included in the analysis{p_end}

{pstd}Conditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(nb_types)}}number of distinct types considered in the conditional analysis{p_end}
{synopt:{cmd:e(I_unit_level_characteristic)}}dummy equal to 1 if the characteristics considered in the conditional analysis are defined at unit level{p_end}
{synopt:{cmd:e(I_withsingle)}}dummy for the use of option {opt withsingle}{p_end}
{synopt:{cmd:e(I_excludingsinglepertype)}}dummy for the use of option {opt excludingsinglepertype}{p_end}
{synopt:{cmd:e(nb_units_total)}}number of units in the dataset used, including single units, across all types{p_end}
{synopt:{cmd:e(nb_units_single)}}number of units with only one individual in
the dataset used, across all types{p_end}
{synopt:{cmd:e(nb_units_studied)}}number of units included in the analysis, depending on option {opt withsingle}, across all types{p_end}
{synopt:{cmd:e(nb_individuals)}}number of individuals included in the analysis
(that is, within the units included in the analysis), across all types{p_end}
{synopt:{cmd:e(nb_minority_individuals)}}number of minority (or reference) individuals included in the analysis, across all types{p_end}
{synopt:{cmd:e(prop_minority_hat)}}estimated proportion of minority (or reference) group, across all types (equal to nb_minority_individuals and  nb_individuals){p_end}
{synopt:{cmd:e(K_max)}}maximal size, that is, number of individuals K in a unit across the units included in the analysis, across all types{p_end}
{synopt:{cmd:e(nb_K_with_obs)}}number of distinct unique unit sizes present across the units included in the analysis, across all types{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(list_K_with_obs)}}list of the unique unit sizes present across the units included in the analysis, across all types{p_end}
{synopt:{cmd:e(type_frequencies)}}number of studied units of each type (unit level) 
or number of individuals within studied units of each type (individual level){p_end}
{synopt:{cmd:e(type_probabilities)}}type_frequencies expressed in proportions{p_end}
{synopt:{cmd:e(summary_info_data_per_type)}}summary information about data for
each type; row ith corresponds to type i, that is, modality equal to i for the
type variable (either Z or W depending on the level of the characteristics);
for each type, the columns show different information as regards data used per
type.  With unit-level covariates, the columns have the following meanings:
1: {cmd:e(I_withsingle};
2: {cmd:e(nb_units_total)};
3: {cmd:e(nb_units_single)};
4: {cmd:e(nb_units_studied)};
5: {cmd:e(nb_individuals)};
6: {cmd:e(nb_minority_individuals)};
7: {cmd:e(prop_minority_hat)};
8: {cmd:e(K_max)};
9: {cmd:e(nb_K_with_obs)}.
With individual-level covariates -- in this case, note that, for each type,
the equivalent of a "unit" in the unconditional analysis is now a "cell",
defined as the intersection of a unit and a given individual type.  For
instance, if we have two individuals types (W = 1 or W = 2), a given unit
with, say, 5 individuals of type 1 and 3 individuals of type 2, is divided
into two cells, one containing the 5 individuals of type 1, the other
containing the 3 individuals of type 2.  The matrix gives some information
about the number of cells per type.  As for units, a cell is called single
whenever it contains only one individual.  The columns have the following
meanings:
1: dummy equal to 1 if single cells are included in the analysis (default),
0 otherwise (option {opt excludingsinglepertype};
2: total number of cells in the data used
(equivalent of nb_units_total, where units are cells);
3: total number of single cells in the data used 
(equivalent of nb_units_single, where units are cells);
4: total number of cells included in the analysis
(equivalent of nb_units_studied, where units are cells);
5: nb_individuals (within the included cells);
6: nb_minority_individuals (within the included cells);
7: prop_minority_hat;
8: maximal size, that is, number of individuals K in a cell across the cells included in the analysis
(equivalent of {cmd:e(K_max)}, where units are cells);
9: number of distinct unique cell sizes present across the cells included in the analysis
(equivalent of {cmd:e(nb_K_with_obs)}, where units are cells).{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(nb_units_studied_per_type)}}with unit-level covariates only,
fourth column of {cmd:e(summary_info_data_per_type)}: number of units included in the analysis per type{p_end}
{synopt:{cmd:e(nb_cells_studied_per_type)}}with individual-level covariates only,
fourth column of {cmd:e(summary_info_data_per_type)}: number of cells included in the analysis per type{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(nb_cells_studied_sum_across_type)}}with unit-level covariates only; total number of cells
included in the analysis (sum across types){p_end}
{synopt:{cmd:e(nb_single_cells_sum_across_type)}}with unit-level covariates only; total number of single cells
(sum across types){p_end}

{pstd}Information relative to the method used:{p_end}

{pstd}Both for unconditional and conditional analyses:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(I_method_np)}}dummy for the use of {cmd:method(np)}{p_end}
{synopt:{cmd:e(I_method_beta)}}dummy for the use of {cmd:method(beta)}{p_end}
{synopt:{cmd:e(I_method_ct)}}dummy for the use of {cmd:method(ct)}{p_end}
{synopt:{cmd:e(I_conditional)}}dummy for conditional analysis (that is, use of
the
option {cmd:conditional()}{p_end}
{synopt:{cmd:e(I_unit_level_characteristic)}}dummy for the use of unit-level covariates in the case of conditional analysis{p_end}
{synopt:{cmd:e(I_hyp_independenceKp)}}dummy for the assumption of independence
between K and p{p_end}
{synopt:{cmd:e(I_noci)}}dummy for the use of option {opt noci}{p_end}
{synopt:{cmd:e(nb_bootstrap_repetition)}}number of bootstrap repetitions used for inference and the test of binomial assumption{p_end}
{synopt:{cmd:e(specified_level)}}if option {opt level()} is used, it indicates the specified level{p_end}
{synopt:{cmd:e(I_testbinomial)}}dummy for the use of option {opt testbinomial}{p_end}
{synopt:{cmd:e(nb_ct_repetition)}}number of repetitions used to perform the CT
correction in {cmd:method(ct)}{p_end}
{synopt:{cmd:e(b_atkinson)}}parameter (often denoted "b" or "beta") used for the Atkinson index{p_end}

{pstd}Information relative to the estimation and inference performed:{p_end}

{pstd}{cmd:method(np)} -- Unconditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(I_constrained_case)}}dummy equal to 1 in "constrained case", 0
for "unconstrained case"; in constrained case, the distribution of the p
variable is identified in the data; in this case, all the segregation indices
are point-identified.  Otherwise, they are only partially identified (except
for the Coworker, which is point identified as long as there is no single
units in the analysis).  We refer to the original article 
(D'Haultf{c 0x9c}uille and Rathelot 2017) for details.{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(estimates_ci)}}matrix that stores the estimates of the 
identification bounds, plus, in the case of inference, CIs
at the usual 90%, 95%, 99% levels (and also at the specified level through
option {opt level()} if any).
The first two columns of the matrix indicate the parameter of interest considered.
The first one, {cmd:Index}, denotes the index with 1 = Duncan,
2 = Theil,
3 = Atkinson with parameter "b",
4 = Coworker.
In the case of multiple unit sizes and without assuming independence between K
and p, the indices are obtained through aggregation of the indices computed
for each unit size.  The aggregation can be done at the unit level, in which
all units enter the aggregation with the same weight, or at the individual
level, in which units are weighted according to their sizes (with larger units
accounting more in the final aggregated index).  Again, we refer to the
original article (D'Haultf{c 0x9c}uille and Rathelot 2017) for details.  The
second column, {cmd:I_indiv_weight}, contains dummies equal to 0 for
unit-level aggregation (unweighted) and 1 for individual-level aggregation
(weighted).  As the additional computation cost is negligible compared with
the estimation, the command {cmd:segregsmall} computes both indices.  With
{cmd:method(np)}, because of the partial identification analysis, there are
two ways of constructing CIs for the segregation indices.  In the case of
inference, before the CIs, the fifth column {cmd:I_ciboundary} is a dummy
equal to 0 if the CIs are constructed using the "interior" CIs and equal to 1
if the CIs are constructed using the "boundary" CIs.  We refer to the original
article (D'Haultf{c 0x9c}uille and Rathelot 2017) for details.{p_end}

{synopt:{cmd:e(info_distribution_of_p)}}stores information about the distribution
of p obtained through the estimation.
We provide a short explanation below and refer to the original article
(D'Haultf{c 0x9c}uille and Rathelot 2017) for details.
Basically, in the data, for each unit size K=k,
we can identify the first k moments of the distribution of p.
Those moments provide information about the distribution of p
conditional on K=k.
In general, a distribution is uniquely defined by its entire list of moment
m1, m2, m3, ....
But it happens that when the distribution happens to be on the frontier
of the moment space, a finite number of first moments are sufficient
to uniquely define the distribution.
Furthermore, in such cases, the distribution has to be a discrete distribution
with specific support points (also known as nodes) and masses.
Without assuming independence between K and p, 
for each unit size K=k
the matrix {cmd:e(info_distribution_of_p)} stores what is known about the distribution
of p conditional on K=k.
It should be read three rows by three rows.
The first {cmd:K_info} introduces the information for the unit size considered,
size k, number of units with that size in the data included in the analysis,
and proportion of units with that size among all included in the analysis.
The fourth column is a dummy equal to 0 when the estimated distribution p|K=k
is not uniquely defined; that is, its corresponding vector of estimated k first moments
is not in the boundary of the moment space. 
In this case, the two following rows of the matrix are empty (missing values .).
The dummy is equal to 1 when 
the estimated distribution p|K=k is uniquely defined
by the estimated k first moments because the vector happens to be in the boundary
of the moment space; it is furthermore a discrete distribution.
In this case, the fifth column {cmd:nb_nodes} indicates the number of support points
of the estimated distribution p|K=k,
and the two following rows report the support points or nodes and the
associated masses.
When assuming independence between K and p
(option {opt independencekp}),
we can identify up to the {cmd:e(K_max)} (the maximal size among the units included
in the analysis) first moment of the unconditional distribution of p.
The matrix {cmd:e(info_distribution_of_p)} has three rows.
The first one has information about the data used: {cmd:e(K_max)}, number of 
units included in the analysis, and a dummy variable indicating whether the distribution of 
p is constrained or not and, if so, the number of nodes
and the estimated distribution of p.
The motivation of {cmd:e(info_distribution_of_p)} is that a segregation measure
is a function of the joint distribution of (K,p) (or of p) only.
By providing those estimated distributions in the constrained case, it allows
users to consider other segregation indices.{p_end}
{synopt:{cmd:e(test_binomial_results)}}When the binomial test is done, which 
is equivalent to doing inference with {cmd:method(np)} (because the additional
computational cost is negligible compared with the bootstrap procedure),
the result of the test is stored in that matrix.
With {cmd:method(np)}, the option {opt testbinomial} forces only the display
of the matrix {cmd:e(test_binomial_results)} in the log, but it is always stored.
It has one row and two columns; the first one stores the value of the test
statistic, the second one the p-value of the test, where the null hypothesis
H0 is the binomial assumption: conditional on unit size K and 
probability than on an arbitrary individual in the unit belonging to the 
minority (or reference) group, the number X of minority (or reference)
individuals in the unit is distributed according to a binomial(K, p).{p_end}

{pstd}{cmd:method(np)} -- Conditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Scalars}{p_end}
{synopt:{cmd:e(I_constrained_case)}}dummy equal to 1 when
it is a "constrained case" for each type; therefore, the aggregated
conditional indices are point identified{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(I_constrained_case_per_type)}}equivalent to
{cmd:e(I_constrained_case)}
in unconditional analysis type by type{p_end}
{synopt:{cmd:e(estimates_ci_aggregated)}}equivalent of {cmd:e(estimates_ci)}
for the conditional aggregated index{p_end}
{synopt:{cmd:e(estimates_ci_type_1)}}equivalent to matrix
{cmd:e(estimates_ci)}
(which stores the estimates of the identification bounds and CIs
for the indices) for type 1{p_end}
{synopt:{cmd:e(estimates_ci_type_2)}} for type 2{p_end}
{synopt:{cmd:e(estimates_ci_type_}{it:#}{cmd:)}}and so forth for
each type up to the number of types used in the conditional analysis{p_end}

{pstd}
For the other methods, the stored objects are overall similar.
They are reported below stressing only the differences with {cmd:method(np)} if necessary.{p_end}

{pstd}
{cmd:method(beta)} -- Unconditional analysis: Both {cmd:method(beta)} and
{cmd:method(np)} estimate exactly the same parameters of interest but with
different estimation techniques: {cmd:method(beta)} assumes a beta
distribution for p|K, while {cmd:method(np)} leaves it unrestricted
(nonparametric approach).  As regards stored objects, the main differences
come from the fact that the issue of partial identification in
{cmd:method(np)} is absent with {cmd:method(beta)} because the beta
parameterization ensures point identification.  Therefore, with
{cmd:method(beta)}, the matrices that store estimation and inference results
directly report the estimated indices and their CIs.  Besides, the
identification and estimation techniques used in {cmd:method(np)} require
conditions that are not satisfied by the Gini index; hence, it is not reported
with {cmd:method(np)}.  It is estimated with {cmd:method(beta)}.{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(estimates_ci)}}analogous to {cmd:e(estimates_ci)} with {cmd:method(np)},
except that the estimated indices replace the estimates of the identification bounds{p_end}
{synopt:{cmd:e(info_distribution_of_p)}}{cmd:method(beta)} assumes a beta
distribution for p conditional on K.
For each unit size k (a row of the matrix), {cmd:e(info_distribution_of_p)}
reports the estimated parameter of the beta distribution:
the first column {cmd:K} is the unit size;
the second column {cmd:nb_units} reports the number of units of size k
included in the analysis;
the third column {cmd:prop_unit} is the proportion of such units among
all units included in the analysis;
the fourth column {cmd:nb_comp} is for consistency with the original method
in Rathelot (2012),  which uses a mixture of beta distribution for 
the distribution of p.  Here the method uses a beta distribution
only (which can be seen as a mixture of betas with one component, hence
the values of that column).
Actually, simulations reveal that the indices obtained via
a beta distribution or a mixture of beta with two components or more are 
extremely close in most settings.
The package uses only a beta distribution to decrease the computational cost.
Besides, the {cmd:method(np)} and {cmd:method(beta)} estimate exactly the same parameters
of interest (contrary to {cmd:method(ct)}).
Therefore, the comparison of both estimates enables one to check whether the beta
distribution assumption for p is sensible;
the fifth and sixth columns report the estimates of the two shape parameters of
a beta distribution (often called "alpha" and "beta").
When independence between K and p is assumed with option 
{opt independencekp}, the estimation of the parameters of the distribution
of p, assumed to be a beta, is performed gathering all units whatever
their size.  {cmd:e(estimates_ci)} contains then only one row that reports the
estimates of the two parameters of the beta distribution and information
about the number of units used for that estimation.{p_end}
{synopt:{cmd:e(test_binomial_results)}} similar to the {cmd:method(np)}
when option {opt testbinomial} is specified.
It is not recommended, however, because it has the same computational cost
as the estimation and inference with {cmd:method(np)}, so it would be 
preferable to obtain the result of the test and the estimation from the
{cmd:method(np)}.{p_end}

{pstd}{cmd:method(beta)} -- Conditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(estimates_ci_aggregated)}}same results as {cmd:e(estimates_ci)} aggregated
across types{p_end}
{synopt:{cmd:e(estimates_ci_type_}{it:#}{cmd:)}}same results as
{cmd:e(estimates_ci)} for type {it:#}{p_end}

{pstd}{cmd:method(ct)} -- Unconditional analysis:
Contrary to methods {cmd:method(np)} and {cmd:method(beta)}, {cmd:method(ct)} estimates a slightly
distinct parameter of interest: the segregation indices considered
with {cmd:method(ct)} are defined as functions of the empirical proportions
X/K.
Given those definitions, the different weights for aggregation (unit or individual)
used in {cmd:method(np)} and {cmd:method(beta)} are irrelevant.
The estimation is made gathering all units, independent of their sizes.
The method proposed by Carrington and Troske (1997) does not provide
CIs for the segregation indices.
Thus, the matrices that store estimation results differ (compare below).{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(estimates_ci)}}stores the result of estimation using
{cmd:method(ct)}.  Each row corresponds to a given index among Duncan, Theil,
Atkinson, Coworker, and Gini.  The first column {cmd:index} is simply an
encoding of the index (as in the {cmd:method(np)}).  The second column
{cmd:prop_based} reports the index computed as an inequality index on the list
of empirical proportions X/K across units; it is sometimes called the "naive"
index.  The third column {cmd:mean_under_ra} ("ra" standing for random
allocation) reports the mean over {opt repct(#)} repetitions of the index in
the counterfactual situation of randomness, where individuals are allocated
randomly across units, keeping fixed the number of units and their sizes.  The
fourth column {cmd:CT_corr} reports the corrected index; the correction uses
the naive index and the expected value of the index under random allocation.
As a tribute to Cortese, Falk, and Cohen (1976) (who appear to be the first to
propose the idea of a comparison with randomness for segregation indices), the
sixth column shows the original segregation score proposed by them.  That
score is defined as the standardized version of the index: that is, the
proportion-based index minus its expected value under random allocation
divided by the standard deviation of the index under random allocation.  The
latter quantity is reported in the fifth column {cmd:sd_under_ra}.  The
remaining columns show the empirical quantiles of the segregation indices
obtained under random allocation ({opt repct(#)} draws of indices under random
allocation).  By default, the 1%, 5%, 10%, 90%, 95%, and 99% percentiles are
reported (sixth to twelfth columns).  With option {opt level()}, the 
1-{opt level(#)}th and {opt level(#)}th quantiles are also reported in the
thirteenth and fourteenth columns, respectively.{p_end}
{synopt:{cmd:e(test_binomial_results)}} similar to the {cmd:method(np)} when
option {opt testbinomial} is specified.  It is not recommended, however,
because it has the same computational cost as the estimation and inference
with {cmd:method(np)}, so it would be preferable to obtain the result of the
test and the estimation from the {cmd:method(np)}.{p_end}

{pstd}{cmd:method(ct)} -- Conditional analysis:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 36 38 2: Matrices}{p_end}
{synopt:{cmd:e(estimates_ci_aggregated)}}same results as {cmd:e(estimates_ci)} aggregated
across types{p_end}
{synopt:{cmd:e(estimates_ci_type_}{it:#}{cmd:)}}same results as
{cmd:e(estimates_ci)} for type {it:#}{p_end}

{pstd}
Miscellaneous:{p_end}

{synoptset 36 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:segregsmall}{p_end}
{synopt:{cmd:e(cmd_arguments)}}arguments of the command as typed{p_end}


{marker references}{...}
{title:References}

{phang}
Carrington, W. J., and K. R. Troske. 1997. On measuring segregation in samples
with small units. {it:Journal of Business & Economic Statistics} 15: 402-409.
{browse "https://doi.org/10.2307/1392486"}.

{phang}
Cortese, C. F., R. F. Falk, and J. K. Cohen. 1976. Further considerations on
the methodological analysis of segregation indices. 
{it:American Sociological Review}
41: 630-637. {browse "https://doi.org/10.2307/2094840"}.

{phang}
D'Haultf{c 0x9c}uille, X., and R. Rathelot. 2017. Measuring segregation on small
units: A partial identification analysis. {it:Quantitative Economics} 8: 39-73. 
{browse "http://doi.org/10.3982/QE501"}.

{phang}
Rathelot, R. 2012. Measuring segregation when units are small: A parametric
approach.  {it:Journal of Business & Economic Statistics} 30: 546-553.
{browse "http://doi.org/10.1080/07350015.2012.707586"}.


{marker authors}{...}
{title:Authors}

{pstd}
Lucas Girard{break}
CREST{break}
Palaiseau, France{break}
lucas.girard@ensae.fr

{pstd}
Xavier D'Haultf{c 0x9c}uille{break}
CREST{break}
Palaiseau, France

{pstd}
Roland Rathelot{break}
University of Warwick{break}
Coventry, UK


{marker alsosee}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 21, number 1: {browse "https://doi.org/10.1177/1536867X211000018":st0631}{p_end}
