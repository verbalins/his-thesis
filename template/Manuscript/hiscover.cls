%%
%% Copyright 2016-2018 by Thomas Fischer <thomas.fischer@his.se>
%%
%% This file has been released under the following license:
%% Creative Commons Attribution-Share Alike 4.0 Unported
%% (CC-BY-SA 4.0)
%%
%% hiscover.cls is a LaTeX class for dissertation/licentiate report covers
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hiscover}[2018/06/20 University of Skovde Thesis Cover class by Thomas Fischer]

\newcommand{\@coatofarmsimagefilename}{CoatOfArms/HiSCoatOfArms-white-english}
\newcommand{\@localizeddoctoraldissertation}{Doctoral Dissertation}
\newcommand{\@localizedlicentiatethesis}{Licentiate Thesis}
\newcommand{\@localizedresearchproposal}{Research Proposal}
\newcommand{\@localizedthesisproposal}{Thesis Proposal}

\newcounter{@numberoflanguagesinoptions}
\DeclareOption{english}{%
\PassOptionsToPackage{swedish,main=english}{babel}%
\stepcounter{@numberoflanguagesinoptions}
}
\DeclareOption{swedish}{%
\renewcommand{\@coatofarmsimagefilename}{CoatOfArms/HiSCoatOfArms-white-swedish}
\renewcommand{\@localizeddoctoraldissertation}{Doktorsavhandling}
\renewcommand{\@localizedlicentiatethesis}{Licentiatexamen}
\renewcommand{\@localizedresearchproposal}{Forskningsförslag}% TODO correct translation?
\renewcommand{\@localizedthesisproposal}{Avhandlingsförslag}% TODO correct translation?
\PassOptionsToPackage{english,main=swedish}{babel}%
\stepcounter{@numberoflanguagesinoptions}
}

\ProcessOptions

\LoadClass{article}

\RequirePackage{ifthen}
\RequirePackage{xstring}
\RequirePackage{graphicx}
% Import font definitions
\RequirePackage{hisfont}
\RequirePackage{histextformatting}
% Import user metadata
\RequirePackage{hismetadata}
\RequirePackage{pagecolor} % Load after xcolor from hismetadata

\isdissertation{
  \RequirePackage[paperwidth=176mm,paperheight=250mm,margin=20mm,top=45mm,bottom=10mm]{geometry}
}{
  \RequirePackage[a4paper,margin=20mm,top=45mm,bottom=10mm]{geometry} %
}
\RequirePackage{luatex85}% required for \pdfpageheight and \pdfpagewidth

% Check that either 'english' or 'swedish' is specified as class option,
% but not both at the same time or none at all
\ifthenelse{\equal{\value{@numberoflanguagesinoptions}}{0}}{%
\PackageError{his-thesis}{One language must be specified as option: either 'english' or 'swedish'}{}%
}{%
\ifthenelse{\equal{\value{@numberoflanguagesinoptions}}{1}}{}{%
\PackageError{his-thesis}{Only one language may be specified as option: either 'english' or 'swedish'}{}%
}}

\usepackage{tikz}
\usetikzlibrary{positioning}

\RequirePackage{hiscover}