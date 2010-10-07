

su
yum groupinstall 'Electronic Lab'
yum install      perl-XML-LibXML

(logout  from root)



chmod 755 ../../bin/* ;\
mkdir ~/bin;\
cp ../../bin/* ~/bin;\

cd socgen
make build_soc
make run_sims
make build_fgpas  ( if you have xilinx webpack 11.5 installed)




