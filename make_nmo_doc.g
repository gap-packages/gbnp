path := Directory( "doc/nmo" ) ;;
main := "nmo_doc.xml";;
nmosourcedir := "../../lib/nmo";;

sources := [ "ncordmachine.gd", "ncinterface.gd", "ncutils.gd", "ncorderings.gd" ];;

files := List(sources, x->JoinStringsWithSeparator([nmosourcedir,x],"/"));

bookname := "nmo";

str := ComposedXMLString(path,main,files);;
r := ParseTreeXMLString(str);;
CheckAndCleanGapDocTree(r);
MakeGAPDocDoc(path, main, files, bookname);
CopyHTMLStyleFiles(path);
