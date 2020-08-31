use strict;
use MdmDiscoveryScript;
use DiscoveryScript;
use Text::CSV;

# Create an MDM document containing small molecules.
my $document = DiscoveryScript::Open("/E:/APE_lab/Docking_Output/DWB3-1_complexes/H129comp_0.pdb", True);

my $filename = "testds.txt";
open(FH, '>:encoding(utf8)', $filename) or die;
my $receptor = $document->ReceptorInFocus;
die "The open document does not have a defined receptor!" unless $receptor;

$document->FocusOnFirstLigand;
my $ligand = $document->LigandInFocus;
die "The open document does not have a defined ligand!" unless $ligand;
$document->IsDataTableViewShown = True;
my $monitor = $document->CreateLigandNonbondMonitor();
my $nonbonds = $monitor->Nonbonds;
foreach my $ligand (sort {$a->Name cmp $b->Name}  @$nonbonds)
{
    printf "%s@%s\n", $ligand->Name, $ligand->TypeNames;
    printf FH "%s@%s\n", $ligand->Name, $ligand->TypeNames;
}
close(FH);