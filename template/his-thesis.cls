%%
%% This is file `his-thesis.cls'
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
%%
%% Copyright 2021-2023 by Simon Lidberg <simon.lidberg@his.se> based on
%%   original code by Thomas Fischer <thomas.fischer@his.se>
%% 
%% This file has been released under the following license:
%% Creative Commons Attribution-Share Alike 4.0 Unported
%% (CC-BY-SA 4.0)
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{his-thesis}[2018/03/07]

% Necessary for included LaTeX classes
\newif\if@titlepage%
\@titlepagefalse%

\RequirePackage[table,svgnames,dvipsnames,xcdraw]{xcolor}
\usepackage{etoolbox}
\RequirePackage[absolute]{textpos}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Metadata options
%%

\RequirePackage{ifthen}% provides \ifthenelse and \newboolean
\RequirePackage[nopagecolor={white}]{pagecolor}
\RequirePackage{xstring}

\definecolor{specialpagebackground}{RGB}{15,191,0}% default value if nothing else is set

\newcommand{\missingparam}[1]{\colorbox{red!30}{{\normalfont\textbf{\textbackslash{}#1}\ not set}}}

\newcommand{\@seriesnumber}{\missingparam{seriesnumber}}
\newcommand{\seriesnumber}[1]{\renewcommand\@seriesnumber{#1}}

\newcommand{\@subtitle}{~}% subtitle cannot be empty, would give compilation errors
\newcommand{\@subtitleUC}{~}% subtitle cannot be empty, would give compilation errors
\newcommand{\subtitle}[1]{\renewcommand{\@subtitleUC}{\MakeUppercase{#1}}\renewcommand\@subtitle{#1}}

\newcommand\@subject{\missingparam{subject}}
\newcommand\subject[1]{\renewcommand\@subject{#1}}
\subject{Informatics}

\renewcommand{\@title}{\missingparam{title}}
\newcommand{\@titleUC}{\missingparam{title}}
\renewcommand{\title}[1]{\renewcommand{\@titleUC}{\MakeUppercase{#1}}\renewcommand{\@title}{#1}%
	\hypersetup{pdftitle={#1}}%
}
%
\renewcommand{\@author}{\missingparam{author}}
\newcommand{\@authorUC}{\missingparam{author}}
\renewcommand{\author}[1]{\renewcommand{\@authorUC}{\MakeUppercase{#1}}\renewcommand{\@author}{#1}%
	\hypersetup{pdfauthor={#1}}%
}
%
\newcommand{\@dissertationarea}{\missingparam{dissertationarea}}
\newcommand{\dissertationarea}[1]{\renewcommand{\@dissertationarea}{#1}}
\dissertationarea{\@subject}
%
\newcommand{\@isbn}{\missingparam{isbn}}
\newcommand{\isbn}[1]{\renewcommand{\@isbn}{#1}}
%
\newcommand{\@printshop}{\missingparam{printshop}}
\newcommand{\printshop}[1]{\renewcommand{\@printshop}{#1}}
\printshop{Stema Specialtryck AB, Borås}

\newcommand{\@publicationtypelong}{\missingparam{publicationtypelong}}
\newcommand{\publicationtypelong}[1]{\renewcommand{\@publicationtypelong}{#1}}

\newcommand{\@publicationtype}{}
\newcommand{\publicationtype}[1]{%
	% Whenever a new publication type is set, redefine special page color
	\ifthenelse{\equal{#1}{licentiate}}{%
	% If publication is a licentiate thesis
	%\definecolor{specialpagebackground}{RGB}{94,97,100}% grey
		\definecolor{specialpagebackground}{RGB}{129,134,142} % CHANGED grey
		\definecolor{specialpagebackgroundcover}{RGB}{49,61,70} % CHANGED Cover background
	}{\ifthenelse{\equal{#1}{dissertation}}{%
	% If publication is a doctoral thesis
	%\definecolor{specialpagebackground}{RGB}{86,34,97}% purple 
		\definecolor{specialpagebackground}{RGB}{133,105,140}% CHANGED purple 
		\definecolor{specialpagebackgroundcover}{RGB}{133,105,140}% CHANGED purple 
	}{\ifthenelse{\equal{#1}{thesisproposal}}{%
	% Color for 'thesisproposal'
		\definecolor{specialpagebackground}{RGB}{0,44,66}% TODO settle with some color for
		\definecolor{specialpagebackgroundcover}{RGB}{0,44,66}% CHANGED other color for the cover
	}
	{% Color for 'researchproposal'
		\definecolor{specialpagebackground}{RGB}{43,59,17}% TODO settle with some color for
		\definecolor{specialpagebackgroundcover}{RGB}{43,59,17}% CHANGED other color for the cover
	}
	}%
	}%
	\renewcommand{\@publicationtype}{#1}%

	\iflanguage{english}{%
		\ifthenelse{\equal{\@publicationtype}{researchproposal}}{\publicationtypelong{Research Proposal}}{%
		\ifthenelse{\equal{\@publicationtype}{thesisproposal}}{\publicationtypelong{Thesis Proposal}}{%
		\ifthenelse{\equal{\@publicationtype}{licentiate}}{\publicationtypelong{Licentiate Thesis}}{%
		\publicationtypelong{Doctoral Dissertation}
		}
		}
		}
	}{%
		\ifthenelse{\equal{\@publicationtype}{researchproposal}}{\publicationtypelong{Forskningsförslag}}{%
		\ifthenelse{\equal{\@publicationtype}{thesisproposal}}{\publicationtypelong{Avhandlingsförslag}}{%
		\ifthenelse{\equal{\@publicationtype}{licentiate}}{\publicationtypelong{Licentiatexamen}}{%
		\publicationtypelong{Doktorsavhandling}
		}
		}
		}
	}
	%
	% Update page background color for cover document
	\ifthenelse{\boolean{@usecover}}{%
		\renewcommand{\nopagecolor}{specialpagebackgroundcover}%
		\newpagecolor{specialpagebackgroundcover}%
	}% end of 'then' for if @usecover
	{}% nothing in 'else'
}

% CHANGE Add partner company information and logo
\newcommand{\@partnercompany}{\missingparam{partnercompany}}
\newcommand{\partnercompany}[1]{\renewcommand{\@partnercompany}{#1}}

\newcommand{\@partnercompanylogo}{\missingparam{partnercompanylogo}}
\newcommand{\partnercompanylogo}[1]{\renewcommand{\@partnercompanylogo}{#1}}

% CHANGE Add thesis abstract for back cover and spik
\newcommand{\@thesissummary}{\missingparam{thesissummary}}
\newcommand{\thesissummary}[1]{\renewcommand{\@thesissummary}{#1}}

\newcommand{\@coverimage}{\missingparam{coverimage}}
\newcommand{\coverimage}[1]{\renewcommand{\@coverimage}{#1}}

\newcommand{\@coverphoto}{\missingparam{coverphoto}}
\newcommand{\coverphoto}[1]{\renewcommand{\@coverphoto}{#1}}

%%
%% End of metadata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options
%%

% Chapters and parts must start on a right-hand page request one.
\newif\if@openright% FIXME necessary?
\@openrighttrue

\newif\if@mainmatter \@mainmattertrue% FIXME necessary?

\newboolean{@isfinal}
\DeclareOption{final}{\setboolean{@isfinal}{true}}

% Boolean to check dissertation status, true if doctoral or licentiate thesis
\newboolean{@isdissertation}
\DeclareOption{dissertation}{\setboolean{@isdissertation}{true} \publicationtype{dissertation}}
\DeclareOption{licentiate}{\setboolean{@isdissertation}{true} \publicationtype{licentiate}}

\DeclareOption{researchproposal}{\publicationtype{researchproposal}}
\DeclareOption{thesisproposal}{\publicationtype{thesisproposal}}

\newcommand{\isdissertation}[2]{\ifthenelse{\boolean{@isdissertation}}{#1}{#2}}
\newcommand{\isfinal}[2]{\ifthenelse{\boolean{@isfinal}}{#1}{#2}}

\newboolean{@usecover}
\DeclareOption{cover}{\setboolean{@usecover}{true}}

%% Ten, eleven, and twelve point size options
\newcommand\@ptsize{0}% FIXME necessary?

% For two-sided printing we use the switch \if@twoside.
% In addition we have to set the \if@mparswitch to get
% any margin paragraphs into the outside margin.
\@twosidetrue
\@mparswitchtrue

% Pass language-specific options "english" and "swedish" to Babel
\DeclareOption{english}{%
\PassOptionsToPackage{main=english,swedish}{babel}
}
\DeclareOption{swedish}{%
\PassOptionsToPackage{main=swedish,english}{babel}
}

%%
%% End of Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Execute Options
%%

% \ExecuteOptions{a4paper,twoside,topside,openright}
\ProcessOptions
\input{his-thesis10.clo}

%%
%% End of Execute Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Required packages
%%

%% Color Definitions
\definecolor{newgray}{RGB}{88,106,118} % CHANGED New gray to use for title and chapter headings

\definecolor{rubin}{RGB}{62,29,64}
\definecolor{safir}{RGB}{0,44,66}
\definecolor{smaragd}{RGB}{43,59,17}
\definecolor{topas}{RGB}{72,45,24}
\definecolor{grafit}{RGB}{49,53,56}

% An orange shade
\definecolor{oxid}{RGB}{234,120,25}

%% To set and restore page color
\xdef\thepagecolornone{white}% this seeming redundant definition is sometimes necessary

\PassOptionsToPackage{pdfpagelabels=false}{hyperref}
%\PassOptionsToPackage{positioning,fit,calc}
\RequirePackage{tikz}

% Translations with babel
\RequirePackage{babel}
% For improved \RaggedLeft, \RaggedRight, and \Centering commands
\RequirePackage{ragged2e}
\RequirePackage[overload]{textcase}% FIXME necessary?

\RequirePackage{luaimageembed}

%\RequirePackage[useregional]{datetime2}
\def\getYear#1{\StrRight{#1}{4}}
\newcommand{\@year}{\getYear{\@date}}
%\newcommand{\@month}{\missingparam{dissertationdate}}
%\newcommand{\@day}{\missingparam{dissertationdate}}
%\newcommand\dissertationdate[1]{%
%	\DTMsavedate{dissertationdate}{#1}
%	\renewcommand{\@year}{\getdateyear{dissertationdate}}%
%	\renewcommand{\@month}{\getdatemonth{dissertationdate}}%
%	\renewcommand{\@day}{\getdateday{dissertationdate}}%
%}

%% Define page size and margins
\isdissertation{% CHANGE New option for research proposals, run with A4 size
    \isfinal{%
    %% Option 'final' is set, so use special paper size
        \RequirePackage[%
        paperwidth=168mm,%
        paperheight=240mm,%
        layoutsize={168mm,240mm},% layout size equals special paper size
        layoutvoffset={0mm},% where to place the dissertation's pages on paper
        layouthoffset={0mm},%
        margin=21mm,% CHANGE 21 mm margins symmetric margins even in two-side layout
        showcrop=false%
        ]{geometry}
    }{%
        %% Option 'final' not set, so use A4 paper with cut marks
        \RequirePackage[%
        a4paper,% use A4 paper as base to print on
        layoutsize={168mm,240mm},% the dissertations internal paper size
        layoutvoffset={28.5mm},% where to place the dissertation's pages on an A4 paper
        layouthoffset={21mm},%
        margin=21mm,% CHANGE 21 mm margins symmetric margins even in two-side layout
        showcrop=true%
        ]{geometry}
    }
}{%
    \RequirePackage[%
    a4paper,% use A4 paper as base to print on
    margin=30mm,% symmetric margins even in two-side layout
    top=35mm,
    bottom=35mm,
    showcrop=true%
    ]{geometry}
}
%% Important: there are various \pdfpagewidth \pdfpageheight statements that
%% change the paper size in mid-document
\RequirePackage{luatex85}% required for \pdfpageheight and \pdfpagewidth

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hisbibliography
%% Include packages for custom functionality
\RequirePackage[backend=biber,datamodel=his-thesis,style=authoryear,natbib,maxbibnames=99,uniquename=false,uniquelist=false,useprefix=true]{biblatex} % CHANGED Added useprefix=true to handle prefixed names

\DeclareNameAlias{sortname}{family-given}

\newbibmacro*{urn}{%\renewbibmacro*{urn}{
 \iffieldundef{urn}
 {}%
 {\adddot\space URN\addcolon\space\printfield{urn}}%
}

% TODO better 'inherit' the official definiton of the following macro
% from standard.bbx and then enhance it for URNs
\renewbibmacro*{doi+eprint+url}{%
  \iftoggle{bbx:doi}
    {\printfield{doi}}
    {}%
  \newunit\newblock
  \iftoggle{bbx:eprint}
    {\usebibmacro{eprint}}
    {}%
  \newunit\newblock
    \usebibmacro{urn}%
  \newunit\newblock
  \iftoggle{bbx:url}
    {\usebibmacro{url+urldate}}
    {}%
}

% Some more nice reading on DeclareSourcemap for the Swedish context:
%  http://blog.sigurdhsson.org/2014/04/extending-biblatex-chicago/
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map[overwrite=true]{
        \pertype{phdthesis}
        % Any PhD thesises (including licentiate thesises) that are
        % part of the 'Dissertation Series' and have an URN
        % from HiS given, change the type from 'phdthesis' to 'histhesis'.
        % File 'his-thesis.dbx' defines a new entry type 'histhesis'
        % that is very similar to the default 'thesis' entry but prints
        % 'Dissertation Series, No. X' as well.
        %\step[fieldsource=series,match={Dissertation Series},final]
        %\step[fieldsource=urn,match=\regexp{^urn:nbn:se:his:},final]
        \step[typesource=phdthesis,typetarget=histhesisnew] % CHANGED New format for dissertation series
        \step[fieldset=disstype, fieldvalue={Doctoral Dissertation}] % CHANGED Add disstype field
        \step[fieldset=note,null] % CHANGED Remove note if present
    }
    \map[overwrite=true]{ % CHANGED Added new mapping here
        % Change each licentiate dissertation to include the custom field value
        \pertype{misc}
        \step[typesource=misc, typetarget=histhesisnew] % CHANGED New format for dissertation series
        \step[fieldset=disstype, fieldvalue={Licentiate Dissertation}] % CHANGED Add disstype field
        \step[fieldset=note,null] % CHANGED Remove note if present
    }
    \map{
      % Remove 'url' field from entries that have a DOI defined
      \step[fieldsource=doi,final]
      \step[fieldset=url,null]
    }
    \map{
      % Remove 'url' field from entries that have an ISSN defined
      \step[fieldsource=issn,final]
      \step[fieldset=url,null]
    }
    \map{
      % Remove 'url' field from entries that have an ISBN defined
      \step[fieldsource=isbn,final]
      \step[fieldset=url,null]
    }
    \map{
      % Remove 'url' field from entries that have an URN defined
      \step[fieldsource=urn,final]
      \step[fieldset=url,null]
    }
    % \map{ % CHANGED added due to DeclareSortingTemplate functionality
    %   \pertype{standard}
    %   \step[fieldsource=number, final]
    %   \step[fieldset=sortkey, origfieldval]
    % }
    % CHANGED Added sorting to correctly sort entries using prefixes, such as van der Zee or von Beethoven
    \map[overwrite=true]{
      \step[fieldsource=translator]
      \step[fieldset=tempsortname, origfieldval]
      \step[fieldsource=editor]
      \step[fieldset=tempsortname, origfieldval]
      \step[fieldsource=author]
      \step[fieldset=tempsortname, origfieldval]
    }
    \map[overwrite=true]{
      \step[fieldsource=tempsortname, match=\regexp{(^|\s+)\Kv[a|o]n\s+(der\s+)?}, replace={$1}]
    }
    \map[overwrite=false]{
      \step[fieldsource=tempsortname]
      \step[fieldset=sortname, origfieldval]
    }
  }
}

\DeclareSortingTemplate{seriesnumber}{ % CHANGED DeclareSortingScheme is deprecated
  \sort{
    \field{presort}
  }
  \sort[final]{
    \field{sortkey}
  }
  \sort[direction=ascending]{
    \field[padside=left,padwidth=3,padchar=0,]{number}
    \literal{999}
    \field{author}
 }
}
\ExecuteBibliographyOptions{sorting=seriesnumber} % CHANGED Support for new sorting template

% Comma between author and year when citing
\renewcommand{\nameyeardelim}{\addcomma\addspace}

% This bibliography will be used for the list of
% previous PhD/licentiate publications as generated
% by the command \dissertationlist
% The filename may be different, important is the
% label which has to equal 'dissertation-series'.
% All publications in this bibliography will be
% printed, no \cite or \nocite command is necessary.
\addbibresource[label=dissertation-series]{dissertation-series.bib}

% The following hyphenation command will take care of
% correctly wrap/breaking words with dashes.
% Add all words with dashes when adding new entries to
% this bibliography.
% Use '=' to signify that there shall be a dash in the
% word even if it is not wrapped. Use '-' to signify a
% valid breaking point. No dash will be printed unless
% the word will get wrapped/broken at this location.
%\hyphenation{Anna=Sofia e=ser-vice game=based Game=Based in-struc-tor=led multi=ob-jec-tive Multi=ob-jec-tive Multi=Ob-jec-tive on=con-di-tion On=con-di-tion pref-er-ence=based Pref-er-ence=based sim-u-la-tion=based time=con-strain Vi-sion=Based}
\hyphenation{Anna-Sofia e-ser-vice game-based Game-Based in-struc-tor-led multi-ob-jec-tive Multi-ob-jec-tive Multi-Ob-jec-tive on-con-di-tion On-con-di-tion pref-er-ence-based Pref-er-ence-based sim-u-la-tion-based time-con-strain Vi-sion-Based} % CHANGED Altered definition due to warnings with =
% Other hyphenations which seem to be problematic:
\hyphenation{Au-ton-o-mous Sköv-de}

%% Prints the list of previous dissertations published
%% in the same series. The list of dissertations is
%% determined by the references labeled 'dissertation-series'
\newcommand\dissertationlist{%
\part*{Publications in the Dissertation Series}% List of references is an unnumbered Part
\phantomsection % CHANGE Fixing hyperref linking
\addcontentsline{toc}{part}{\protect\texorpdfstring{\uppercase{Publications in the Dissertation Series}}{Publications in the Dissertation Series}}% manually add this unnumbered Part to ToC (not automatically as it is the star'ed version)
%\markboth{}{\uppercase{Publications in the Dissertation Series}}% fix headings (odd pages 'Publications in the Dissertation Series', even pages empty)
\chapter*{Publications in the Dissertation~Series} % CHANGE New chapter title
\renewcommand{\leftmark}{PUBLICATIONS} % CHANGE New heading on these pages
\begingroup
\DeclareFieldFormat{title}{##1} % CHANGE Regular title
\DeclareFieldFormat{isbn}{\mkbibacro{ISBN}\space ##1} % CHANGE Remove colon after ISBN
\defbibheading{subbibliography}{%
% No title, purple-colored page right before bibliography
}
\begin{refsection}[dissertation-series]
    \begin{refcontext}[sorting=seriesnumber]
        \tolerance=1
        \emergencystretch=\maxdimen
        \hyphenpenalty=10000
        \hbadness=10000
        \defbibenvironment{bibliography} % CHANGE Enumerated publications in the dissertation-series
            {\begin{enumerate}}
            {\end{enumerate}}
            {\item}
        \nocite{*}
        \printbibliography[heading=subbibliography]
    \end{refcontext}
\end{refsection}
\endgroup
\isdissertation{\cleardoublepage}{\clearpage}
}%

%% List of References as cited by the dissertation
%% author in his/her report. Essentially a nice
%% wrapper around \printbibliography.
\newcommand{\listofreferences}{%
	\isdissertation
	{\part*{\refname}
	\phantomsection % CHANGE Fixing hyperref linking
	\chapter*{\MakeUppercase{\refname}} % CHANGE Also chapter
	\renewcommand{\leftmark}{\MakeUppercase{\refname}} % CHANGE TO UPDATE CHAPTER HEADING FOR STAR CHAPTER
	\addcontentsline{toc}{part}{\protect\texorpdfstring{\MakeUppercase{\refname}}{References}}% manually add this unnumbered Part to ToC (not automatically as it is the star'ed version)
	}% List of references is an unnumbered Part if dissertation or licentiate
	{\clearpage
	\pdfbookmark[chapter]{References}{references} % CHANGE To include an entry in the bookmarks section of the PDF
	\chapter*{\MakeUppercase{\refname}} % Chapter otherwise
	\phantomsection % CHANGE Fixing hyperref linking
	}% fix headings (odd pages 'References', even pages empty)
	\markboth{}{\uppercase{\refname}}
	\begingroup%
	\defbibheading{subbibliography}{%
	% No title, purple-colored page (generated by \part*) right before bibliography
	}
	\begin{refcontext}[sorting=nyt]
	\tolerance=1
	\emergencystretch=\maxdimen
	\hyphenpenalty=10000
	\hbadness=10000
	\printbibliography[heading=subbibliography]
	\end{refcontext}
	\endgroup
}% end of \listofreferences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tabular

% Nice tabular rules
\RequirePackage{booktabs}

% To be able to define new tabular column types
\RequirePackage{array}
% Left-aligned, fixed width column
\newcolumntype{L}[1]{>{\RaggedRight\arraybackslash}p{#1}}
% Right-aligned, fixed width column
\newcolumntype{R}[1]{>{\RaggedLeft\arraybackslash}p{#1}}
% Centered, fixed width column
\newcolumntype{C}[1]{>{\Centering\arraybackslash}p{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ????

%% For letter-spacing
\RequirePackage{soulutf8}
% ???
\sodef\an{}{.095em}{0.35em plus0.35em}{2em plus.5em minus.5em}
\newcommand*\MyUpperCase[1]{\MakeUppercase{\an {#1}}}
% ???
\sodef\coverpagesubjectspacing{}{3pt}{8pt}{0pt}
\sodef\coverpagetitlespacing{}{3pt}{8pt}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Draft Mode

%% In draft mode, an orange-colored bar is drawn next to text
%% which is too wide for the current box. Usually, the author
%% has to fix that manually.
%%
%% Based on
%% http://tex.stackexchange.com/questions/28294/can-i-have-the-overfullrule-rule-colored-in-pdflatex
%% https://github.com/raphink/overcolored
\ifluatex
\RequirePackage{luatexbase,luacode}
\begin{luacode}

orangebox = function(head)
  while head do
    if head.id == 0 or head.id == 1 then
      -- go through the hlists (the rows)
      orangebox(head.head)

    -- if there's a rule after the rightskip, this is the overfull box
    -- node id 10 == glue, glue subtype 9 is rightskip, node id 2 is a rule

    elseif head.id == 10 and head.subtype == 9 and head.next and head.next.id == 2 then
       -- this must be an overfull box
       local w1, w2
       w1 = node.new("whatsit","pdf_literal")
       w1.data = "q 1 0.6667 0.3333 rg"
       w1.mode = 1
       w2 = node.new("whatsit","pdf_literal")
       w2.data = " Q"
       w2.mode = 1

       w1.next = head.next -- the rule
       head.next = w1      -- color start
       w1.next.next = w2   -- color end

       node.slide(head)    -- adjust prev pointers
    end
    head = head.next
  end
  return true
end
luatexbase.add_to_callback("post_linebreak_filter",orangebox,"orangebox")

\end{luacode}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hisownpublications
\RequirePackage{pdfpages}
\newcounter{ownpublicationsenumi}
\setcounter{ownpublicationsenumi}{0}

%% In theory, using \enumerate and \endenumerate should work,
%% but there are some compilation issues with the default
%% implementation. Using this one instead:
\def\enumerate{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
        {\@enumctr}\itemsep 0pt\parsep 0pt
         \def\makelabel##1{\hss\llap{##1}}}\fi}
\let\endenumerate =\endlist


\defbibenvironment{ownpublicationsbibenvironment}%
{\enumerate\setcounter{enumi}{\value{ownpublicationsenumi}}}%
{\setcounter{ownpublicationsenumi}{\value{enumi}}\endenumerate}%
{\item}

\DeclareBibliographyCategory{ownpublicationshighrelevance}
\DeclareBibliographyCategory{ownpublicationslowrelevance}
\DeclareBibliographyCategory{ownpublications}

\newenvironment{ownpublications}{%
\isdissertation{\cleardoublepage}{\clearpage}
\pdfbookmark[section]{Publications}{publications} % CHANGE To include an entry in the bookmarks section of the PDF
\chapter*{Publications}%
\sloppy
%\phantomsection
}{%
%\clearpage%
\fussy
\setcounter{ownpublicationsenumi}{0}%
}

\newcommand{\highrelevancepublications}[1]{%
\begin{refcontext}[sorting=none]
\addtocategory{ownpublicationshighrelevance}{#1}\nocite{#1}
\printbibliography[heading=subbibliography,title=Publications with High Relevance,env=ownpublicationsbibenvironment,category=ownpublicationshighrelevance]
\end{refcontext}
}

\newcommand{\lowrelevancepublications}[1]{%
\begin{refcontext}[sorting=none]
\addtocategory{ownpublicationslowrelevance}{#1}\nocite{#1}
\printbibliography[heading=subbibliography,title=Publications with Low Relevance,env=ownpublicationsbibenvironment,category=ownpublicationslowrelevance]
\end{refcontext}
}

\newcommand{\authorspublications}[1]{%
\begin{refcontext}[sorting=none]
\addtocategory{ownpublications}{#1}\nocite{#1}
\printbibliography[heading=none,env=ownpublicationsbibenvironment,category=ownpublications]
\end{refcontext}
}

\newcommand{\authorspublication}[2][]{%
\stepcounter{ownpublicationsenumi}%
\subsection*{Paper \Roman{ownpublicationsenumi}}%
\fullcite{#2}%
\ifthenelse{\equal{#1}{}}{}{\par\textit{Author's contribution}: #1}% print optional author's contributions
}

% Retrieving a publication's title, without quotation marks or any other 'candy'.
% Title can be retrieved 'verbatim' (as it is) or in uppercase.
\DeclareFieldFormat{verbatim}{#1}
\DeclareFieldFormat{uppercase}{\MakeUppercase{#1}}
%\DeclareFieldFormat{titlecase}{\MakeLowercase{#1}}
%\DeclareCiteCommand{\citetitlecase}{}{\printfield[titlecase]{title}}{}{}
\DeclareCiteCommand{\citetitleverbatim}{}{\printfield[verbatim]{title}}{}{}
\DeclareCiteCommand{\citetitleuppercase}{}{\printfield[uppercase]{title}}{}{}

% CHANGE to incorporate additional optional arguments to this function.
% First optional argument is optional arguments for includepdf, defaults to scale=.85,clip=true,pages=-. #1
% First mandatory argument is a path to the pdf file. #2
% Second mandatory argument is the reference code to the article. #3
% Second optional argument is the prefix to the full citation. #4
% Third optional argument is the suffix to the full citation. #5
\NewDocumentCommand \fullarticle {O{scale=.85,clip=true,pages=-} m m O{} O{}}{%
\stepcounter{ownpublicationsenumi}
\isdissertation{\cleardoublepage}{\clearpage}
\phantomsection
\addcontentsline{toc}{section}{\texorpdfstring{Paper~\Roman{ownpublicationsenumi}: \citetitleverbatim{#2}}{Paper~\Roman{ownpublicationsenumi}}}% CHANGE added texorpdfstring to fix hyperref linking. % section-like line in ToC, but does not appear in main text body
\IfNoValueTF {#4}%
    { \IfNoValueTF {#5}% No value for #4, then check #5.
        {\partlike[\MakeUppercase{Paper~\Roman{ownpublicationsenumi}}]{\citetitleuppercase{#2}}}
        {\partlike[\MakeUppercase{Paper~\Roman{ownpublicationsenumi}}]{\citetitleuppercase{#2}}[\fullcite{#2} #5]}
    }%
    { \IfNoValueTF {#5}% Value for #4, then check #5.
        {\partlike[\MakeUppercase{Paper~\Roman{ownpublicationsenumi}}]{\citetitleuppercase{#2}}[\fullcite{#2} #5]}
        {\partlike[\MakeUppercase{Paper~\Roman{ownpublicationsenumi}}]{\citetitleuppercase{#2}}[#4 \fullcite{#2} #5]}
    }% nice purple page with article's title, like special page for parts, but does not appear in ToC and does not try to make it uppercase
\nopagecolor
\ifthenelse{\boolean{@isfinal}}{%
    \newgeometry{margin=0cm}%
    \includepdf[#1,noautoscale,clip=true]{#3}% include article's PDF, but scale it to fit the smaller pages' size
    \restoregeometry%
}{%
    \includepdf[#1,frame=true]{#3}% include article's PDF, but keep author's scaling intact
}
}%

\newenvironment{fullarticles}[1][Previously Published Articles]{%
\markboth{}{}% no page header
\isdissertation{\cleardoublepage}{\clearpage}
\phantomsection
\part*{Previously Published Articles}
\addcontentsline{toc}{part}{\texorpdfstring{\MakeUppercase{#1}}{#1}}% part-like line in ToC, but does not appear in main text body
}{%
\isdissertation{\cleardoublepage}{\clearpage}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{bookmark} % CHANGE Needed to include entries in the bookmarks section of the PDF
\bookmarksetup{numbered, open} % CHANGE Options to bookmark
\RequirePackage{xparse} % CHANGE Added xparse package to enable the extension of partlike
% Letter spacing support (\textls}
\RequirePackage{letterspace}
%%
%% End of Required packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Line spacing parameters
%%

\setlength\lineskip{0\p@}
\setlength\normallineskip{0\p@}

%%
%% End of Line spacing parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Paragraph style parameters
%%

\renewcommand\baselinestretch{}
\setlength\parskip{4.5\p@ \@plus0\p@}
\parindent=\z@

%%
%% End of Paragraph style parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@item[#1]{%
  \if@noparitem
    \@donoparitem
  \else
    \if@inlabel
      \indent \par
    \fi
    \ifhmode
      \unskip\unskip \par
    \fi
    \if@newlist
      \if@nobreak
        \@nbitem
      \else
        \addpenalty\@beginparpenalty
        \addvspace\@topsep
        \addvspace{-\parskip}%
      \fi
    \else
      \addpenalty\@itempenalty
      \addvspace\itemsep
    \fi
    \global\@inlabeltrue
  \fi
  \everypar{%
 \RaggedRight %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \@minipagefalse
    \global\@newlistfalse
    \if@inlabel
      \global\@inlabelfalse
      {\setbox\z@\lastbox
       \ifvoid\z@
         \kern-\itemindent
       \fi}%
      \box\@labels
      \penalty\z@
    \fi
    \if@nobreak
      \@nobreakfalse
      \clubpenalty \@M
    \else
      \clubpenalty \@clubpenalty
      \everypar{}%
    \fi}%
  \if@noitemarg
    \@noitemargfalse
    \if@nmbrlist
      \refstepcounter\@listctr
    \fi
  \fi
  \sbox\@tempboxa{\makelabel{#1}}%
  \global\setbox\@labels\hbox{%
    \unhbox\@labels
    \hskip \itemindent
    \hskip -\labelwidth
    \hskip -\labelsep
    \ifdim \wd\@tempboxa >\labelwidth
      \box\@tempboxa
    \else
      \hbox to\labelwidth {\unhbox\@tempboxa}%
    \fi
    \hskip \labelsep}%
  \ignorespaces}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Penalties
%%

%% \nopagebreak and \nolinebreak penalties
\@lowpenalty   51		% book default
\@medpenalty  151		% book default
\@highpenalty 301		% book default

% The following penalties are not used in book. Should we use them?
%%% Line breaking penalties
%\pretolerance=100           % Pass 1 of line breaking algorithm
%\tolerance=200              % Pass 2 of line breaking algorithm
%\doublehyphendemerits=5000  % Two consecutive hyphenated lines: 10000
%\finalhyphendemerits=5000   % Second to the last line is hyphenated
%\adjdemerits=10000          % Two adjacent visually incompatible lines
%\linepenalty=10             % Added for each line
%\looseness=0                % Try to make the paragraph \looseness longer
%
%%% Implicit horizontal penalties
%\hyphenpenalty=50   % Line break in hyphenated word
%\exhyphenpenalty=50 % Same as above, pre-text empty
%\binoppenalty=700   % Line break after binary operation
%\relpenalty=500     % Line break at math relation operator
%
%%% Implicit vertical penalties
%\clubpenalty=500            % Club line at bottom of page: 150
%\widowpenalty=500           % Widow line at top of page: 150
%\displaywidowpenalty=150    % Widow in front of display: 50
%\brokenpenalty=100          % Between hyphenated line and following line
%\predisplaypenalty=10000    % Forbid breaking in front of display
%\postdisplaypenalty=0       % Allow break after display
%
%%% Box related counter parameters
%\hbadness=10000 % Report if badness of hbox > \hbadness: 1000
%\vbadness=10000 % Report if badness of vbox > \vbadness: 1000
%\hfuzz=0.1pt    % Report if overfull width of hbox > \hfuzz: 0.1pt
%\vfuzz=0.1pt    % Report if overfull width of vbox > \vfuzz: 0.1pt

%%
%% End of Penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\headerfooterfont}{\isdissertation{\fontarial{6}{6}}{\fontarial{9}{9}}}
\newcommand{\staticheadertext}{\textcolor{newgray}{\MakeUppercase{\leftmark}}} % CHANGED TO NEW FORMAT
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\def\ps@headings{%
    \def\@evenhead{\headerfooterfont\staticheadertext\hfil}%
    \def\@evenfoot{\headerfooterfont\thepage\hfil}%
    \def\@oddhead{\headerfooterfont\hfil\staticheadertext}%
    \def\@oddfoot{\headerfooterfont\hfil\thepage}%
    \let\@mkboth\markboth
}%
\def\ps@footeronly{%
    \def\@evenhead{}%
    \def\@evenfoot{\headerfooterfont\thepage\hfil}%
    \def\@oddhead{}%
    \def\@oddfoot{\headerfooterfont\hfil\thepage}%
    \let\@mkboth\markboth
}%

% CHANGE Redefine cleardoublepage to not have footers on the empty page
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\vspace{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\newcommand\@chapapp{\chaptername}
\newcommand\frontmatter{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}}
\newcommand\mainmatter{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmatter{%
  \cleardoublepage
  \@mainmatterfalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parts
%%

% CHANGE Now allows for additional optional parameters. 
% #1 is upper text, #2 is middle text, and #3 is lower text. #1 and #3 are optional.
\NewDocumentCommand\partlike{O{}mO{}}{% CHANGE Now allows for additional optional parameters.
  \@beginpart
   \begingroup\color{white}\raggedleft% \RaggedLeft
   \IfNoValueTF{#1}%
        {\begingroup\fontarial{13.5}{15.0} \par\endgroup}%
        {\begingroup\fontarial{13.5}{15.0}#1\par\endgroup}%
   \begingroup\fontarial{16.5}{21.0}#2\par\endgroup%
   \IfNoValueTF{#3}%
        {}%
        {\medskip\par\begingroup\fontarial{9.5}{10.5}#3\par\endgroup}%
   \endgroup%
  \@endpart%
}

% Hack to get two optional arguments into \partlike
% see: http://www.tex.ac.uk/FAQ-twooptarg.html
\newcommand{\partlikeRelay}[2][]{%
  \@beginpart
   \begingroup\color{white}\raggedleft% \RaggedLeft
   \ifthenelse{\equal{\OptArgPartlike}{}}{}{\begingroup\fontarial{13.5}{15.0}\OptArgPartlike\par\endgroup}%
   \begingroup\fontarial{16.5}{21.0}#2\par\endgroup%
   \ifthenelse{\equal{#1}{}}{}{\medskip\par\begingroup\fontarial{9.5}{10.5}#1\par\endgroup}%
   \endgroup%
  \@endpart%
}

\newcommand\part{%
  \secdef\@part\@spart}% for part*, use @spart, for non-star part use @part

\def\@part[#1]#2{%
	\@beginpart
     \begingroup\color{white}\raggedleft% \RaggedLeft
     \begingroup\fontarial{16.5}{21.0}\MyUpperCase{#1}\par\endgroup%
     \endgroup%
    \@endpart%
}

%% The actual formatting of the title of the part (star form)
\def\@spart#1{%
    \@beginpart
     \begingroup\color{white}\raggedleft% \RaggedLeft
     \begingroup\fontarial{16.5}{21.0}\MyUpperCase{#1}\par\endgroup%
     \endgroup%
    \@endpart%
}
% CHANGED Do not count PART pages
\newcounter{mypagecount}% create a new counter
\setcounter{mypagecount}{0}% set it to something just in case

%% The actual formatting of the beginning of the part (both star and non-star forms)
\def\@beginpart{%
    \isdissertation{\cleardoublepage}{\clearpage}
    \setcounter{mypagecount}{\value{page}} % CHANGED Do not count PART pages
	\isdissertation{%
		\isfinal{%
		  \eject \pdfpagewidth 168mm \pdfpageheight 240mm% Set paper size to 168mm x 240mm
		}{%
		  % In non-final mode, i.e. when printing on A4, do not change paper size
		}
	}{%
	}
    
    \null%\vfill
    % Define a dark purple color used for page backgrounds
    \newpagecolor{specialpagebackground}%
    \markboth{}{}% no page header
    \thispagestyle{empty}% no page numbers on just this page
	%\vspace{34.74mm}%
    \vspace*{44mm}% CHANGE Should be 70mm from top of paper
}

%% The actual formatting of the end of the part (both star and non-star forms)
\def\@endpart{%
    \vfill
    \isdissertation{\newpage}{}%
    \null%
    \thispagestyle{empty}%
    \isdissertation{%
		\isfinal{%
		  \eject \pdfpagewidth 168mm \pdfpageheight 240mm% Set paper size to 168mm x 240mm
		}{%
		  % In non-final mode, i.e. when printing on A4, do not change paper size
		}
	}{}%
    \isdissertation{\newpage}{\clearpage}%
    \setcounter{page}{\value{mypagecount}} % CHANGED Do not count PART pages
    \restorepagecolor% restore original page color
}

%%
%% End of Parts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapters
%%

\newcommand\chapter{\isdissertation{\cleardoublepage}{\clearpage}% chapter shall start on a fresh right page if dissertation
                    \thispagestyle{footeronly} % CHANGE No heading on first page of chapter
                    \global\@topnum\z@% ???
                    \@afterindentfalse% ???
                    \secdef\@chapter\@schapter}% for chapter*, use @schapter, for non-star chapter use @chapter
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne% ???
                       \if@mainmatter% if in main text body (i.e. not ToC, LoC, LoF, ...)
                         %\isdissertation{}{\ifthenelse{\value{chapter}<1}{\pdfbookmark[chapter]{\@publicationtypelong}{proposal} % CHANGE To include an entry in the bookmarks section of the PDF
                         %\part*{\@publicationtypelong}}{}}
                         \refstepcounter{chapter}% increase chapter counter
                         %\typeout{\@chapapp\space\thechapter.}% debug output in console
                         \renewcommand{\leftmark}{\chaptername~\thechapter~#1}
                         \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter.}\texorpdfstring{\MakeUppercase{#1}}{#1}}% will appear in ToC CHANGED dot after number
                       \else
                         \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{#1}}{#1}}% chapters in frontmatter or backmatter, will appear in ToC
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeUppercase{#1}}{#1}}% will appear in ToC
                    \fi
                    \addtocontents{lof}{\protect\addvspace{10\p@}}% add vertical space between chapters in list of figures
                    \addtocontents{lot}{\protect\addvspace{10\p@}}% add vertical space between chapters in list of tables
                    \@makechapterhead{#2}%
                    \@afterheading}
\def\@makechapterhead#1{% non-star chapter
  %\vspace*{29\p@}% Add some vertical space between top of page and where text "Chapter N" starts
  \vspace*{44mm} % CHANGE 70 mm from top of page, margin is 21 mm
  % Above vertical spacing is a guess work so that the user-defined chapter's title's placement matches the star'ed version
  {\parindent \z@ \raggedright
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter% if in main text body (i.e. not ToC, LoC, LoF, ...)
        \isdissertation{
            \fontarial{13.5}{15}
            \addfontfeature{LetterSpace=7.5}% LetterSpace: 1pt / 13.5pt * 100 = 7.4
        }{
            \fontarial{15}{16.5}
            \addfontfeature{LetterSpace=7.5}% LetterSpace: 1pt / 15pt * 100 = 6.7
        }
        \MakeUppercase{\@chapapp}\space \thechapter
        \nobreak
        \vskip 1.5\p@
      \fi
    \fi
    \interlinepenalty\@M
    \isdissertation{
        \fontarial{16.5}{18}
        \addfontfeature{LetterSpace=7.5}% LetterSpace: 1.5pt / 16.5pt * 100 = 9.1
    }{
        \fontarial{18}{19.5}
        \addfontfeature{LetterSpace=7.5}% LetterSpace: 1.5pt / 18pt * 100 = 8.3
    }
    \MakeUppercase{#1}\par\nobreak
    \vskip 14\p@
  }}
\def\@schapter#1{\@makeschapterhead{#1}%
                 \@afterheading}
\def\@makeschapterhead#1{% star chapter
  %\vspace*{50\p@}% Add some vertical space between top of page and where text "This Is The Chapter Title" starts
  \vspace*{44mm}% CHANGE 70 mm from top of page, margin is 21 mm. Add some vertical space between top of page and where text "This Is The Chapter Title" starts
  {\parindent \z@ \raggedright
    \interlinepenalty\@M
    \isdissertation{
        \fontarial{16.5}{18}
        \addfontfeature{LetterSpace=7.5}% LetterSpace: 1.5pt / 16.5pt * 100 = 9.1
    }{
        \fontarial{18}{19.5}
        \addfontfeature{LetterSpace=7.5}% LetterSpace: 1.5pt / 18pt * 100 = 8.3
    }
    \uppercase{#1}\par\nobreak
    \vskip 14\p@
  }}

%%
%% End of Chapters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sections
%%

%% Parameters of \@startsection
%%  name: e.g., subsection
%%  level: a number, denoting depth of section - e.g., chapter = 0, section = 1, etc.
%%  indent: Indentation of heading from left margin; \z@ is short for zero
%%  beforeskip: Absolute value = skip to leave above the heading.
%%       If negative, then paragraph indent of text following heading is suppressed
%%  afterskip: If positive, then skip to leave below heading,
%%       else negative of skip to leave to right of run-in heading.
%%  style: Commands to set style. Since June 1996 release the last command in this
%%       argument may be a command such as \MakeUppercase or \fbox that takes an
%%       argument. The section heading will be supplied as the argument to this
%%       command. So setting #6 to, say, \bfseries\MakeUppercase would produce bold,
%%       uppercase headings.
%% If * is missing, then increment the counter. If it is present, then there should
%% be no [<altheading>] argument. The command uses the counter secnumdepth. It
%% contains a pointer to the highest section level that is to be numbered.

%% First level heading (swedish: underrubrik 1)
%% LetterSpace: 1pt / 13.5pt * 100 = 7.4
\newcommand\section{\@startsection{section}{1}{\z@}%
                                  {-18pt \@plus -4pt \@minus -2pt}%
                                  {2.8pt \@plus 2pt}%
                                  {\isdissertation{%
                                   \fontarial{13.5}{15}\addfontfeature{LetterSpace=7.5}\MakeUppercase
                                   }{%
                                    \fontarial{15}{16.5}\addfontfeature{LetterSpace=7.5}\MakeUppercase}}}

%% Second level heading (swedish: underrubrik 2)
%% LetterSpace: 0.5pt / 10.5pt * 100 = 4.8
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-18pt \@plus -4pt \@minus -2pt}%
                                     {2.8pt \@plus 2pt}%
                                     {\isdissertation{%
                                     \fontarial{10.5}{11}\addfontfeature{LetterSpace=5}\MakeUppercase
                                     }{%
                                     \fontarial{12}{13.5}\addfontfeature{LetterSpace=5}\MakeUppercase}}}

%% Third level heading (swedish: unterrubrik 3)
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-5pt \@plus -2pt \@minus -.5pt}%
                                     {0.1pt}%
                                     {\isdissertation{%
                                        \fontarial{9.5}{11}%
                                        }{%
                                        \fontarial{11}{12.5}}}}

%% Fourth level heading: like third-level heading, but inline
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {-5pt \@plus -2pt \@minus -.5pt}%
                                    {-1em}%
                                    {\isdissertation{%
                                        \fontarial{9.5}{11}%
                                        }{%
                                        \fontarial{11}{12.5}}}}

%%
%% End of Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lists
%%

%% Modified from latex.ltx
\renewenvironment{enumerate}{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\setlength{\rightmargin}{0.33cm}	% Right margin indented 0.33 cm
        \usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}}%
  \fi}{\endlist}

%% Modified from latex.ltx
\renewenvironment{itemize}{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\setlength{\rightmargin}{0.33cm}		% Right margin indented 0.33 cm
      \setlength\labelwidth{0.45em}		% Bullet positioned just to the
      \setlength\labelsep{0.5cm-\labelwidth}	% right of the left margi.
      \def\makelabel##1{\hss\llap{##1}}}%
  \fi}{\endlist}

\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}

\setlength\topsep{0pt}
\setlength\partopsep{\topsep}
\setlength\parsep{\parskip}
\setlength\itemsep{0pt}
\setlength\labelsep{0.75em}
\setlength\labelwidth{0.5cm}
\setlength\leftmargini{0mm}
\addtolength\leftmargini{\labelwidth}
\leftmarginii\leftmargini
\leftmarginiii\leftmargini
\leftmarginiv\leftmargini
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}

%\setlength  \labelsep  {.5em}
%\setlength  \labelwidth{\leftmargini}
%\addtolength\labelwidth{-\labelsep}
%\@beginparpenalty -\@lowpenalty
%\@endparpenalty   -\@lowpenalty
%\@itempenalty     -\@lowpenalty
%\renewcommand\theenumi{\@arabic\c@enumi}
%\renewcommand\theenumii{\@alph\c@enumii}
%\renewcommand\theenumiii{\@roman\c@enumiii}
%\renewcommand\theenumiv{\@Alph\c@enumiv}
%\newcommand\labelenumi{\theenumi.}
%\newcommand\labelenumii{(\theenumii)}
%\newcommand\labelenumiii{\theenumiii.}
%\newcommand\labelenumiv{\theenumiv.}
%\renewcommand\p@enumii{\theenumi}
%\renewcommand\p@enumiii{\theenumi(\theenumii)}
%\renewcommand\p@enumiv{\p@enumiii\theenumiii}
%\newcommand\labelitemi{\textbullet}
%\newcommand\labelitemii{\normalfont\bfseries \textendash}
%\newcommand\labelitemiii{\textasteriskcentered}
%\newcommand\labelitemiv{\textperiodcentered}

%%
%% End of Lists
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Environments
%%

%% Description environment
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

%% Quote environment
\newenvironment{quote}{%
	\par%
	\smaller%
	\begingroup%
	\leftskip4em%
	\rightskip\leftskip%
}{%
	\par%
	\endgroup%
}

%% Appendix environment
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}

%%
%% End of Environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for existing environments
%%

%% Column separation in array = 5\arraycolsep
\setlength\arraycolsep{5\p@}

%% Column separation in tabular = 2\tabcolsep
\setlength\tabcolsep{6\p@}

%% Width of rules in array and tabular
\setlength\arrayrulewidth{.4\p@}

%% Space between adjacent rules in array and tabular
\setlength\doublerulesep{2\p@}

%% Amount of space put in by \ in tabbing environment
\setlength\tabbingsep{\labelsep}

%% Space between last line of text and footnotes in a minipage
\skip\@mpfootins = \skip\footins

%% Space around text in a \fbox
\setlength\fboxsep{3\p@}

%% Width of rules made by \fbox and \framebox
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}

%% Layout of equation numbers
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}

%%
%% End of Parameters for existing environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figures
%%

%% Figure counter
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}

%% Floating parameters
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}

%% Single and double column figures respectively
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}

%%
%% End of Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tables
%%

%% Table counter
\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}

%% Floating parameters
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}

%% Generate number for caption
\def\fnum@table{\tablename\nobreakspace\thetable}

%% Single and double column tables respectively
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

%%
%% End of Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Captions for floating objects
%%

%% White space above and below caption
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}

%% Called with caption number (e.g., "Figure 1.2:") and caption text
\long\def\@makecaption#1#2{%
  \relsize{-1}% slightly smaller font size for figure/table captions
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%		% Measure the width of the caption
  \ifdim \wd\@tempboxa >\hsize		% Does it fit on one line?
    #1: #2\par		% Yes, normal paragraph
  \else		% No, center
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%%
%% End of Captions for floating objects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Import font definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% More Symbols

\RequirePackage{MnSymbol}

% Avoid "LaTeX Error: Command `\mathdollar' already defined." error
%\makeatletter%
%\let\mathdollar\@undefined%
%\makeatother%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% General font definition

% Will work with LuaLaTeX and XeLaTeX (?), but not classical LaTeX
% !!! [no-math] is required to avoid issues in combination with package MnSymbol
% !!! see here for details: http://tex.stackexchange.com/questions/171286/big-brackets-are-always-opening-and-square-when-using-fontspec-with-mnsymbol
\RequirePackage[no-math]{fontspec}

\defaultfontfeatures{Ligatures=TeX}

%% Missing Georgia or Arial? Linux users may want to look into
%% http://corefonts.sourceforge.net/
%% https://packages.debian.org/wheezy/ttf-mscorefonts-installer
%% Windows users should have the fonts in any case
\setmainfont{Georgia}
\setsansfont{Arial}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Commands to switch btwn serif/sans-serif and to set font size
\newcommand{\fontarial}[2]{%
	\fontsize{#1}{#2}%
	\selectfont%
	\sffamily%
}
\newcommand{\fontgeorgia}[2]{%
	\fontsize{#1}{#2}%
	\selectfont%
	\rmfamily%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Definition for Source Code Listings

% To allow relative font sizes as used below for listings
\RequirePackage{relsize}

% Nice source code listings
\RequirePackage{listings}
\lstset{%
	basicstyle=\ttfamily\relsize{-1},% default font formatting
	keywordstyle=\textbf,% how to format recognized keywords
	breaklines=true,% allow to break long lines
	breakindent=5pt,% indent wrapped/broken lines
	prebreak={\mbox{\ensuremath{\rhookswarrow}}},% show a nice symbol when breaking lines
	postbreak=\space,% ???
	showtabs=false,% show tabulators?
	tabsize=4,% step widths of tabulators
	numbers=left,% show line numbers on the left
	numberstyle=\relsize{-2},% small font size for numbers
	numberblanklines=false,% no line numbers for empty lines
	numbersep=2ex,% horizontal spacing between numbers and code
	xleftmargin=2em,% ???
	floatplacement=t,% ask LaTeX to place float on the top of a page
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Font changing
%%

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

%%
%% End of Font changing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of contents, list of figures, and list of tables
%%

%% Name of TOC
% This hack is necessary as making uppercase of 'innehåll' as defined by
% package 'babel' will result in 'INNEHåLL'
\iflanguage{swedish}{%
% if language is Swedish
\addto\captionsswedish{\renewcommand{\contentsname}{INNEH{\AA}LL}%
}
}{%
% if language other than Swedish, let 'babel' do its magic
}

%% Levels of headings included in table of contents
\setcounter{tocdepth}{2}

%% Width of page numbers
\newcommand\@pnumwidth{1.55em}

%% Width of right margin
\newcommand\@tocrmarg{0em}	% Flush right

%% Separation of dots (in mu units)
\newcommand\@dotsep{1.0}

%% Produce table of contents
\newcommand\tableofcontents{%
    \cleardoublepage
    \pdfbookmark[section]{\contentsname}{toc} % CHANGE To include an entry in the bookmarks section of the PDF
    \chapter*{\MakeUppercase{\contentsname}% manual make-uppercase necessary, automatic upper-casing inside \chapter* does not work(?)
        \@mkboth{\MakeUppercase\contentsname}%
                {\MakeUppercase\contentsname}%
    }%
    \@starttoc{toc}%		% Make the actual toc
    }

%% Format part entries in toc
%% Called with \numberline{<\thepart>}{<heading>} and <page>
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%	% Add some vertical space
    \setlength\@tempdima{3em}%		% Width of \numberline{<\thepart>}{<heading>}
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth	% No indent, room for page numbers
      \parfillskip -\@pnumwidth		% No overfull messages
      {\leavevmode
      % Large number and heading, and
      % right flushed page number with osf
       %\bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par % CHANGED remove bold chapter& and parts headings in TOC
       #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}

%% Called with \numberline{<\thechapter>}{<heading>} and <page>
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    %\vskip 1.0em \@plus\p@ % CHANGED
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      %\leavevmode \bfseries % CHANGED remove bold chapter and parts headings in TOC
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

%% Format section entries in toc
%% Use definitions in latex.ltx
%% Called with \numberline{<\thesection>}{<heading>} and <page>
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}

%% Produce list of figures
\newcommand\listoffigures{%
    \isdissertation{\cleardoublepage}{\clearpage}
    \pdfbookmark[section]{\listfigurename}{lof} % CHANGE To include an entry in the bookmarks section of the PDF
    \chapter*{\MakeUppercase{\listfigurename}}% manual make-uppercase necessary, automatic upper-casing inside \chapter* does not work(?)
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%		% Make the actual lof
    }

%% Format figure entries in lof
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

%% Produce list of tables
\newcommand\listoftables{%
    \isdissertation{\cleardoublepage}{\clearpage}
    \pdfbookmark[section]{\listtablename}{lot} % CHANGE To include an entry in the bookmarks section of the PDF
    \chapter*{\MakeUppercase{\listtablename}}% manual make-uppercase necessary, automatic upper-casing inside \chapter* does not work(?)
      \@mkboth{\MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%		% Make the actual lot
    }

%% Produce entry in lot
\let\l@table\l@figure

%%
%% End of Table of contents, list of figures, and list of tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Footnotes
%%

%% No rule above footnotes
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}

%% Format footnote
%% Called with text of footnote
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}

%% Format the footnote markers that are printed in the text
%\def\@makefnmark{\hbox{\temfivespace\@textsuperscript{\normalfont\@thefnmark}}}

%%
%% End of Footnotes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cover section
%%

\setlength{\TPHorizModule }{1mm}
\setlength{\TPVertModule }{1mm}

\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}

\sodef\bookspinespacing{}{.1em}{8pt}{0pt}% TODO adjust last two parameters ('inner space' and 'outer space')

%\newcommand{\}{} % CHANGE: Removed this, gave error

% CHANGE Function to adapt the font size of the title to fit the allotted space, 25pt size default
% \usepackage{environ}% http://ctan.org/pkg/environ
% \newdimen\fontdim
% \newdimen\upperfontdim
% \newdimen\lowerfontdim
% \newif\ifmoreiterations
% \fontdim25pt % CHANGE 

% \newbox\trialbox
% \newbox\linebox
% \global\newcount\maxbad
% \newcount\linebad
% \newcount\currenthbadness

% \NewEnviron{fitbox}[2]{% \begin{fitbox}{<width>}{<height>} stuff \end{fitbox}
    % % Store environment body
    % \def\stuff{%
        % \BODY%
    % }%
    % % prepare badness box
    % \def\badnessbox{%
        % \global\maxbad=0\relax%
        % \currenthbadness=\hbadness% save old \hbadness
        % \hbadness=10000000\relax% make sure, TeX reports overfull boxes
        % \message{Starting measureline recursion with width #1^^J}%
        % \setbox\trialbox=\vbox{%
            % \hsize#1\relax%
            % \fontsize{\fontdim}{1.2\fontdim}%
            % \selectfont%
            % \stuff\par%
            % \measurelines% start recursion
        % }%
% %       \noindent\usebox\trialbox\par
        % \hbadness=\currenthbadness% restore old \hbadness
    % }%
    % % prepare recursion to measure line badness
    % \def\measurelines{%
        % \message{Iteration of measurelines^^J}%
        % \begingroup%
            % \setbox\linebox=\lastbox% get the last line
            % \setbox0=\hbox to \hsize{\unhcopy\linebox}% put the last line into box0 to provoke badness calculation
            % \linebad=\the\badness\relax% \badness now reflects the last typeset box, i.e. box0
            % \message{Badness: \the\badness\space\the\linebad\space with max \the\maxbad\space at Fontsize: \the\fontdim\space^^J}%
            % \ifnum\linebad>\maxbad% store the maximum badness
                % \global\maxbad=\linebad% Uncomment this line to ignore overfull hboxes!
            % \fi%
            % \ifvoid% end of recursion
                % \linebox%
            % \else%
                % \unskip\unpenalty\measurelines% do the recursion
                % \ifhmode%
                    % \newline%
                % \fi%
                % \noindent\box\linebox% do the output
            % \fi%
        % \endgroup%
    % }%
    % % Prepare measurement box
    % \def\buildbox{%
        % \badnessbox% measure badness
        % \setbox0\vbox{% measure height
            % \hbox{%
                % \fontsize{\fontdim}{1.2\fontdim}%
                % \selectfont%
                % \minipage{#1}%
                    % \vbox{%
                        % \stuff\par%
                    % }%
                % \endminipage%
            % }%
        % }%
        % \message{Measured badness: \the\maxbad\space at Fontsize: \the\fontdim\space^^J}%
        % \dimen@\ht0
        % \advance\dimen@\dp0
        % \message{Measured box height: \the\dimen@\space^^J}%
    % }%
    % \def\shrinkheight{%
        % \loop
            % \fontdim.5\fontdim % Reduce font size by half
            % \buildbox
            % \message{Shrinking, new box height: \the\dimen@\space at Fontsize: \the\fontdim\space^^J}%
        % \ifdim\dimen@>#2 \repeat
        % \lowerfontdim\fontdim
        % \upperfontdim2\fontdim
        % \fontdim1.5\fontdim
    % }%
    % \def\shrinkwidth{%
        % \loop
            % \fontdim.5\fontdim % Reduce font size by half
            % \buildbox
        % \ifnum\maxbad>10000 \repeat
        % \lowerfontdim\fontdim
        % \upperfontdim2\fontdim
        % \fontdim1.5\fontdim
    % }%
    % \def\growheight{%
        % \loop
            % \fontdim2\fontdim % Double font size
            % \buildbox
            % \message{Growing, new box height: \the\dimen@\space at Fontsize: \the\fontdim\space^^J}%
        % \ifdim\dimen@<#2 \repeat
        % \upperfontdim\fontdim
        % \lowerfontdim.5\fontdim
        % \fontdim.75\fontdim
    % }%
    % \buildbox
    % % Compute upper and lower bounds
    % \ifdim\dimen@>#2
        % \message{Need to shrink box height: \the\dimen@\space^^J}%
        % \shrinkheight
    % \else
        % \message{Need to grow box height: \the\dimen@\space to target: #2^^J}%
        % \growheight
    % \fi
    % \message{Max font: \the\upperfontdim\space^^J}%
    % \message{Min font: \the\lowerfontdim\space^^J}%
    % % Potentially further reduce bounds for overfull box
    % \ifnum\maxbad>10000
        % \shrinkwidth
    % \fi 
    % \message{Max font adjusted: \the\upperfontdim\space^^J}%
    % \message{Min font adjusted: \the\lowerfontdim\space^^J}%
    % % Now try to find the optimum height and width
    % \loop
        % \buildbox
        % \message{Height: \the\dimen@\space^^J}%
        % \ifdim\dimen@>#2
            % \moreiterationstrue
            % \upperfontdim\fontdim
            % \advance\fontdim\lowerfontdim
            % \fontdim.5\fontdim
        % \else
            % \ifnum\maxbad>10000
                % \moreiterationstrue
                % \upperfontdim\fontdim
                % \advance\fontdim\lowerfontdim
                % \fontdim.5\fontdim
            % \else
                % \advance\dimen@-#2
                % \ifdim\dimen@<10pt
                    % \lowerfontdim\fontdim
                    % \advance\fontdim\upperfontdim
                    % \fontdim.5\fontdim
                    % \dimen@\upperfontdim
                    % \advance\dimen@-\lowerfontdim
                    % \ifdim\dimen@<.2pt
                        % \moreiterationsfalse
                    % \else
                        % \moreiterationstrue
                    % \fi
                % \else
                    % \moreiterationsfalse
                % \fi
            % \fi
        % \fi
    % \ifmoreiterations \repeat
    % \message{Selected font: \the\fontdim\space^^J}%
    % \fontarial{\fontdim}{1.2\fontdim}% CHANGE Set correct font
    % \vbox to #2{\box0\hbox{}}% Typeset content
% }%

\newcommand{\cover}[2]{%
	\internalcoverpage{#1}%
	\isdissertation{%
	  \eject \pdfpagewidth 198mm \pdfpageheight 250mm% Set paper size to 198mm x 250mm
	  \newpage%
	  \internalbookspine
	  \internallastpage{#2}%
	}{%
	  \newpage
	}%
}

\newcommand{\internalcoverpage}[1]{%
	\begingroup%
	\vphantom{A}% problems with completely empty pages ...
	\isdissertation{%
		\isfinal{%
			\begin{textblock}{176}(0,0)%
		}{%
			\begin{textblock}{176}(21,28.5)%
		}
	}{%
		\begin{textblock}{176}(0,0)%
	}
	\begin{tikzpicture}[inner sep=0pt]%
	% background image in rubin/purple using the laurel branch for dissertation and licentiate. None for the proposals.
	\ifthenelse{\equal{\@publicationtype}{dissertation}}{% if dissertation ...
		\node[anchor=south west](backgroundimage) at (0mm,0mm) {\includegraphics[width=176mm,height=250mm,keepaspectratio]{logos/laurelbranch-rubin}};%
	}{%
		\ifthenelse{\equal{\@publicationtype}{licentiate}}{% if licentiate ...
			\node[anchor=south west](backgroundimage) at (0mm,0mm) {\includegraphics[width=176mm,height=250mm,keepaspectratio]{logos/laurelbranch-grafit}};%
		}{%
		% no background image for 'thesisproposal' or 'researchproposal'
		}% end of if licentiate
	}% end of if dissertation
	\end{tikzpicture}%
	\end{textblock}%

	\isdissertation{%
		\isfinal{
			\begin{textblock}{138}(18,21) % Doctoral / licentiate dissertation
		}{
			\begin{textblock}{138}(39,49.5) % Doctoral / licentiate dissertation
		}
	}{%
	  \begin{textblock}{176}(18,21) % Research Proposal / Thesis Proposal
	}
	% Coat of Arms on page's top left side
	\includegraphics[height=35mm,width=35mm,keepaspectratio]{logos/HiSCoatOfArms-white-\languagename}%
	%\includegraphicsembedded[height=35mm,width=35mm,keepaspectratio]{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njl9NpSjSss28cCO2D1mssXIE8H6vb0pFzm+QvsBH/kEadBSP3zQAZ+DjjfiVgT83HR+uubt7qOB5dZElrWRXQplNPS4rtIyzumclo/jwgn+z+v/AaHC1uwKZW5kc3RyZWFtCmVuZG9iago4IDAgb2JqCiAgIDEzNzQ0CmVuZG9iago3IDAgb2JqCjw8CiAgIC9FeHRHU3RhdGUgPDwKICAgICAgL2EwIDw8IC9DQSAxIC9jYSAxID4+CiAgID4+Cj4+CmVuZG9iagoxIDAgb2JqCjw8IC9UeXBlIC9QYWdlcwogICAvS2lkcyBbIDYgMCBSIF0KICAgL0NvdW50IDEKPj4KZW5kb2JqCjkgMCBvYmoKPDwgL0NyZWF0b3IgKGNhaXJvIDEuMTAuMiAoaHR0cDovL2NhaXJvZ3JhcGhpY3Mub3JnKSkKICAgL1Byb2R1Y2VyIChjYWlybyAxLjEwLjIgKGh0dHA6Ly9jYWlyb2dyYXBoaWNzLm9yZykpCj4+CmVuZG9iagoxMCAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZwogICAvUGFnZXMgMSAwIFIKPj4KZW5kb2JqCnhyZWYKMCAxMQowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMTQ2MDMgMDAwMDAgbiAKMDAwMDAwMDIwOSAwMDAwMCBuIAowMDAwMDAwMDE1IDAwMDAwIG4gCjAwMDAwMDAxODggMDAwMDAgbiAKMDAwMDAwMDUyMyAwMDAwMCBuIAowMDAwMDAwMzA5IDAwMDAwIG4gCjAwMDAwMTQ1MzEgMDAwMDAgbiAKMDAwMDAxNDUwNyAwMDAwMCBuIAowMDAwMDE0NjY4IDAwMDAwIG4gCjAwMDAwMTQ3OTUgMDAwMDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSAxMQogICAvUm9vdCAxMCAwIFIKICAgL0luZm8gOSAwIFIKPj4Kc3RhcnR4cmVmCjE0ODQ4CiUlRU9GCg==}
	\vspace*{3cm plus 5mm minus 5mm}%
	\par%
	%
	% user content comes here
	\IfSubStr{coverimage not set}{#1}
	{\vspace*{8cm}} % Show empty space if image not supplied
	{%
		\IfSubStr{includegraphics}{#1}% Check if the user supplied an includegraphics command
		{#1}%
		{\includegraphics[width=\textwidth,height=8cm]{#1}}%
	}
	% after user content:
	\par%
	\vspace*{5mm}\vfil%
	%
	\begin{minipage}[t]{\linewidth}%
		\RaggedRight%
		\color{white}%
		\begingroup\fontgeorgia{13.5}{13.5}%
		\MakeUppercase{\coverpagesubjectspacing{\@publicationtypelong}}
		\par\endgroup%
		\vspace*{4mm}%
		\begingroup\fontarial{25}{25}
		%\begin{fitbox}{\linewidth}{3cm} % CHANGE Include the new function here to constrain the title
		  \flushleft\MakeUppercase{\coverpagetitlespacing{\@title}}% CHANGE Make sure to disable hyphenation
		%\end{fitbox}%
		\par\endgroup

		\vspace*{4mm}%

		% CHANGE Check if subtitle is defined in metadata.tex
		% If defined, show it with the same command as the title
		% Else, just skip with the same amount of space. This gives the author and subject a fixed position
		\ifthenelse{\equal{\@subtitleUC}{~}}{%
			\vspace*{5mm}%
		}{%
			\begingroup\fontarial{14.5}{14.5}%
			%\begin{fitbox}{\linewidth}{5mm} % CHANGE Include the new function here to constrain the subtitle
			\@subtitle
			%\end{fitbox}%
			\par\endgroup%
		}%
			
		\vspace*{4mm}%

		\begingroup\fontarial{14.5}{14.5}\color{oxid}\MakeUppercase{\@author}\par\endgroup%

		\vspace*{1mm}%

		\begingroup\fontgeorgia{12}{12}\textit{\@subject}\par\endgroup%
	\end{minipage}%
	\end{textblock}%
	\endgroup%
}

\newcommand{\internalbookspine}{%
	\vphantom{A}% problems with completely empty pages ...
	\begin{textblock}{22}(176,20)%
	\centering%
	\begin{tikzpicture}[inner sep=0pt]%
		\node[rotate=-90,color=white,anchor=west](author){%
			\begingroup\color{white}\fontarial{8.5}{8.5}%
			\textbf{\color{oxid}\bookspinespacing{\MakeUppercase{\@author}}}%
			\par\endgroup
		};
		\node[rotate=-90,below=3mm of author.east,anchor=west,color=white,align=left](title){%
			\begingroup\color{white}\fontarial{8.5}{8.5}%
			\bookspinespacing{\MakeUppercase{\@title}}%
			\par\endgroup
		};
		\node[rotate=-90,below=3mm of title.east,anchor=west,color=white](year){%
			\begingroup\color{white}\fontarial{8.5}{8.5}%
			\@year%
			\par\endgroup
		};
	\end{tikzpicture}%
	\par%
	\end{textblock}%
}

\newcommand{\internallastpage}[1]{%
	\begingroup%
	\vphantom{A}% problems with completely empty pages ...
	\isdissertation{%
		\isfinal{%
			\begin{textblock}{88}(50,50) % Final dissertation
		}{%
			\begin{textblock}{88}(50,50) % Not final dissertation
		}
	}{%
	  \begin{textblock}{176}(50,50) % Research Proposal / Thesis Proposal
	}
	\begin{tikzpicture}[inner sep=0mm]%
		\color{white}% use white text color due to dark purple background


		% Photo
		\isdissertation{%
			\node[minimum width=31.05mm,minimum height=37.25mm](photobg){%
			};% end of \node(photobg)
		}{%
			\node[minimum width=35.05mm,minimum height=41.25mm](photobg){%
			};% end of \node(photobg)
		}
		\node[left=0mm of photobg.south west,anchor=south west](photo){%
		\isdissertation{%
			\IfSubStr{includegraphics}{#1}%
			{#1}%
			{\includegraphics[height=37.25mm,width=31.05mm,keepaspectratio]{#1}}
		}{%
			\IfSubStr{includegraphics}{#1}%
			{#1}%
			{\includegraphics[height=41.25mm,width=35.05mm,keepaspectratio]{#1}}%
		}
		};% end of \node(photo)


		% Name
		\isdissertation{\def\nameSize{53.75mm}}{\def\nameSize{78.75mm}}
		\node[right=4mm of photobg.south east,anchor=south west,text width=\nameSize](name){%
		\isdissertation{%
			\begingroup\fontarial{10}{10}\MakeUppercase{\@author}\par\endgroup%
		}{%
			\begingroup\fontarial{14.5}{14.5}\MakeUppercase{\@author}\par\endgroup%
		}
		};% end of \node(name)


		% User content (abstract)
		\isdissertation{\def\abstractSize{88mm}}{\def\abstractSize{113mm}}
		\node[below=5mm of photobg.south west,anchor=north west,text width=\abstractSize,text justified](abstract){%
			\begingroup
			\isdissertation{%
				\fontarial{11}{12}%
			}{%
				\fontarial{13}{14.5}%
			}
			
			% user content comes here
			% CHANGE Check for empty parameter here. If empty, use the thesissummary, otherwise use nothing.
			\@thesissummary
			% after user content:
			\par\endgroup%
		};% end of \node(abstract)


		% If performed within a collaboration
		\iscollaboration{% only if collaboration partner is defined ...
			% Horizontal white line
			\draw[line width=1pt,white]([yshift=-3mm]abstract.south west)--([yshift=-3mm]abstract.south east);
			% Collaboration text and logo
			\node[below=12mm of abstract.south west,anchor=north west,text width=\abstractSize,align=flush center](collaborationlabel){%
				\begingroup
				\isdissertation{%
					\fontarial{7}{7.5}%
				}{%
					\fontarial{9}{11}%
				}
				\MakeUppercase{In collaboration with}\par\endgroup%
			};% end of \node(collaborationlabel)
			\node[below=4mm of collaborationlabel](collaborationlogo){%
			\includegraphics[width=27.5mm,height=27.5mm,keepaspectratio]{\@partnercompanylogo}%
			};% end of \node(collaborationlogo)
		}{}% end of "only if collaboration partner is defined ..."


		% Only include ISBN and dissertation number for doctorate and licentiate
		\isdissertation{%
		  % ISBN and Dissertation Number
		  \node[text width=88mm,align=flush center,below=169mm of photo.north west,anchor=north west](number) {%
		  \begingroup\fontarial{8.5}{11}%
		  ISBN \@isbn\\%
		  Dissertation Series, No.~\@seriesnumber~(\@year)%
		  \par\endgroup%
		  };% end of \node(number)
		}{}%
	\end{tikzpicture}%
	\end{textblock}%
	\endgroup%
	\clearpage
}

%%
%% End of cover
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Titlepage
%% 
\renewcommand{\maketitle}{%
	\pagestyle{empty}
	\setcounter{page}{0}

	\isdissertation{%
		\cleardoublepage%
		\begingroup%
		\centering%
		\vspace*{5.6cm}% value taken from Word template
		\begingroup%
		\fontarial{9.5}{12}%
		\textls[125]{% increase letter spacing by 125/1000em
			\newdimen\origiwspc%
		    \origiwspc=\fontdimen2\font% original inter word space
			\fontdimen2\font=0.5em% inter word space
			\@titleUC%
			\fontdimen2\font=\origiwspc% (original) inter word space
			\par%
		}% textls
		\endgroup%
		\fontarial{9.5}{10.5}\@subtitle%
		\par%
		\endgroup
	}{%
	}

	\isdissertation{\cleardoublepage}{\clearpage}

	\begingroup%
	\centering%
	\vspace*{3cm plus 2cm minus 2cm}
	{\fontgeorgia{11.5}{11.5}\MakeUppercase{\@publicationtypelong}\par}%
	\vspace*{4mm}
	\textls[125]{% increase letter spacing by 125/1000em
		\color{newgray}\fontarial{12.5}{16} % CHANGE New gray color
		\newdimen\origiwspc%
		\origiwspc=\fontdimen2\font% original inter word space
		\fontdimen2\font=0.5em% inter word space
		\@titleUC%
		\fontdimen2\font=\origiwspc% (original) inter word space
		\par%
	}% textls
	\vspace*{4mm}
	{\fontarial{9.5}{11.5}\@subtitle\par}%
	\vspace*{1cm}
	{\fontarial{8.5}{10}\@authorUC\par}%
	{\fontgeorgia{8}{9}\textit{\@subject}\par}%
	\vspace*{3cm plus 1cm minus 1cm}
	\includegraphics[width=3.4cm,height=3.4cm,keepaspectratio]{logos/HiSCoatOfArms-grafit-median-\languagename}\par%
	\endgroup%

	\clearpage%
	\vspace*{\fill}%
	\iscollaboration{% Include Company logo if supplied
		{\centering\includegraphics[width=3.4cm,height=3.4cm,keepaspectratio]{\@partnercompanylogo}\par}% 
	}{%
		{\centering\par }
	}%
	\vspace*{\fill}\par%
	\begingroup%
	{\centering%
		\fontgeorgia{11.5}{14}%
		\@author, \@year%
		\smallskip\par%
		{\fontgeorgia{9.5}{12}\@publicationtypelong\smallskip\par}%
		{\fontgeorgia{12}{15}\textit{Title:} \@title\par}%
		{\fontgeorgia{8.5}{10}\ifthenelse{\equal{\@subtitle}{}}{}{\@subtitle\par}}%
		\medskip%
		University of Skövde \@year, Sweden\\%
		\href{https://www.his.se/}{www.his.se}
		\isdissertation{%
			\bigskip\par%
			\textit{Printer:} \@printshop
			\medskip\par%
			ISBN \@isbn\par%
			Dissertation Series No. \@seriesnumber~(\@year)%
		}{%
		}
	\par}%
	\endgroup%
	\@titlepagefalse
}% END \newcommand{\maketitle}
%%
%% End of Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matter sections
%%

\newcommand{\thesisabstract}[1]{%
	\isdissertation{\cleardoublepage}{\clearpage}
	\pdfbookmark[section]{Abstract}{abstract} % CHANGE To include an entry in the bookmarks section of the PDF
	\chapter*{Abstract}
	#1
}

\newcommand{\thesissammanfattning}[1]{%
	\isdissertation{\cleardoublepage}{\clearpage}
	\pdfbookmark[section]{Sammanfattning}{sammanfattning} % CHANGE To include an entry in the bookmarks section of the PDF
	\begin{otherlanguage}{swedish}
	\chapter*{Sammanfattning}
	#1
	\end{otherlanguage}
}

\newcommand{\thesisacknowledgements}[1]{%
	\isdissertation{\cleardoublepage}{\clearpage}
	\pdfbookmark[section]{Acknowledgements}{acknowledgements} % CHANGE To include an entry in the bookmarks section of the PDF
	\chapter*{Acknowledgements}
	#1
}

\usepackage[titles]{tocloft}
    \renewcommand{\cftdotsep}{1}
    \renewcommand{\cftpartfont}{\fontarial{9.5}{11}}
    \renewcommand{\cftpartpagefont}{\fontarial{9.5}{11}}
    \renewcommand{\cftpartleader}{\cftdotfill{\cftdotsep}}
    
    \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
    \renewcommand{\cftchapfont}{\fontarial{9.5}{11}}
    \renewcommand{\cftchappagefont}{\fontarial{9.5}{11}}
    
    \renewcommand{\cftsecfont}{\fontarial{9.5}{11}}
    \renewcommand{\cftsecpagefont}{\fontarial{9.5}{11}}
    
    \renewcommand{\cftsubsecfont}{\fontarial{9.5}{11}}
    \renewcommand{\cftsubsecpagefont}{\fontarial{9.5}{11}}
    
    \renewcommand{\cftfigfont}{\fontarial{9.5}{11}}
    \renewcommand{\cftfigpagefont}{\fontarial{9.5}{11}}
    %\renewcommand{\cftsubfigfont}{\fontarial{9.5}{11}}
    %\renewcommand{\cftsubfigpagefont}{\fontarial{9.5}{11}}
    
    \renewcommand{\cfttabfont}{\fontarial{9.5}{11}}
    \renewcommand{\cfttabpagefont}{\fontarial{9.5}{11}}
    %\renewcommand{\cfttabindent}{\cftchapindent}
    %\renewcommand{\cftsubtabfont}{\fontarial{9.5}{11}}
    %\renewcommand{\cftsubtabpagefont}{\fontarial{9.5}{11}}
    %\renewcommand{\cftsetpnumwidth}{0.5em}

% Front matter specification
\renewenvironment{frontmatter}{%
	%\hypersetup{pageanchor=false}
    \ifthenelse{\boolean{@usecover}}{%
        \renewcommand{\nopagecolor}{specialpagebackgroundcover}%
        \newpagecolor{specialpagebackgroundcover}%
		\pagenumbering{arabic}
		\pagestyle{empty}
		\newpage
		\internalcoverpage{\@coverimage}
        \newpage
        \restorepagecolor
		\restoregeometry
    }{}
	\@titlepagetrue
    \maketitle
	\@titlepagefalse
    \clearpage
    \markboth{}{}% no page header
    %\hypersetup{pageanchor=true}
	\pagenumbering{Roman}% Switch to Roman page numbers
    \setcounter{page}{1}% Start page numbers from 'I' (Roman 1)
    \pagestyle{footeronly}
    \justifying
    
    % Set default font
    \isdissertation{%
        \fontgeorgia{9.5}{11}
    }{%
        \fontgeorgia{11}{12.5}
    }%
}{%
    \tableofcontents
    \listoffigures
    \listoftables
    
    \isdissertation{\cleardoublepage}{\clearpage}
    \pdfbookmark[section]{Abbreviations}{abbreviations} % CHANGE To include an entry in the bookmarks section of the PDF
    \chapter*{Abbreviations}
    \renewcommand{\glossarysection}[2][]{} % Remove the added section in printglossary
    \printglossary
    
    \isdissertation{\cleardoublepage}{\clearpage}
    \pagestyle{headings}
	\pagenumbering{arabic}% Switch to Arabic page numbers
    \setcounter{page}{1}% Start page numbers from '1'
	\mainmatter
}

\renewenvironment{backmatter}{%
    \@mainmatterfalse
    \sloppy
    \listofreferences
}{%
    \dissertationlist
    \fussy
    \ifthenelse{\boolean{@usecover}}{%
		\isdissertation{\cleardoublepage}{\clearpage}
        \renewcommand{\nopagecolor}{specialpagebackgroundcover}%
        \newpagecolor{specialpagebackgroundcover}%
		\pagestyle{empty}
		\ifthenelse{\boolean{@isfinal}}{}{
			\newgeometry{showcrop=false}
		}
		
		\isdissertation{%
			\eject \pdfpagewidth 198mm \pdfpageheight 250mm% Set paper size to 198mm x 250mm
			\newpage
			\internalbookspine
		}{%
		}
        \internallastpage{\@coverphoto}%
        \restorepagecolor
    }{}
}

%%
%% End matter sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialization
%%

%% Distance between two columns in two column mode
\setlength\columnsep{10\p@}

%% Width of rule between two columns in two column mode
\setlength\columnseprule{0\p@}

%% Use headings as default pag style
\pagestyle{headings}

%% Arabic page numbers
\pagenumbering{arabic}

% Set default font to Georgia 9.5pt if dissertation (not A4 format), else 11pt
\isdissertation{%
  \fontgeorgia{9.5}{11}
}{%
  \fontgeorgia{11}{12.5}
}

\usepackage[shortlabels]{enumitem} % Indentation of lists
\setlist[enumerate,1]{leftmargin=0.75cm}
\setlist[itemize,1]{leftmargin=0.75cm}

\usepackage{hyperref}
\input{metadata}

\newboolean{@iscollaboration}
\ifthenelse{\equal{\@partnercompany}{\missingparam{partnercompany}} \OR \equal{\@partnercompanylogo}{\missingparam{partnercompanylogo}}}
{\setboolean{@iscollaboration}{false}}{\setboolean{@iscollaboration}{true}}
\newcommand{\iscollaboration}[2]{\ifthenelse{\boolean{@iscollaboration}}{#1}{#2}}

%%
%% End of Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput

%%
%% End of file `his-thesis.cls'.
