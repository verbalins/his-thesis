ensure_path( 'TEXINPUTS', './template//', '.' );
$ENV{'TZ'}='Europe/Stockholm';
$pdflatex = 'lualatex -file-line-error %O %S --shell-escape';
$lualatex = "lualatex --shell-escape -file-line-error %O %S";
$pdf_mode = 4;
$bibtex_use = 2;

$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib acn acr alg %R.xdy';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] ); #handle -outdir param by splitting path and file, ...
    pushd $path; # ... cd-ing into folder first, then running makeglossaries ...

    if ( $silent ) {
        system "makeglossaries -q '$base_name'"; #unix
        # system "makeglossaries", "-q", "$base_name"; #windows
    }
    else {
        system "makeglossaries '$base_name'"; #unix
        # system "makeglossaries", "$base_name"; #windows
    };

    popd; # ... and cd-ing back again
}

#############
# makeindex #
#############
@ist = glob("*.ist");
if (scalar(@ist) > 0) {
    $makeindex = "makeindex -s $ist[0] %O -o %D %S";
}
