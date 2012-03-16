s/#GBNP.Incr uses:[^#]*#/#GBNP.Incr uses:#/
s/#GBNP.Incr is used in:[^#]*#/#GBNP.Incr is used in: DetermineGrowthQA#/
s/#GBNP.IncrT uses:[^#]*#/#GBNP.IncrT uses: GBNP.RedAddToTree#/
s/#GBNP.IncrT is used in:[^#]*#/#GBNP.IncrT is used in: FinCheckQA#/
s/#PreprocessAnalysisQA uses:[^#]*#/#PreprocessAnalysisQA uses: GBNP.RedAddToTree GBNP.TreeToList#/
s/#PreprocessAnalysisQA is used in:[^#]*#/#PreprocessAnalysisQA is used in:#/
s/#FinCheckQA uses:[^#]*#/#FinCheckQA uses: GBNP.CreateOccurTreeLR GBNP.IncrT GBNP.LookUpOccurTreePTSLRPos GBNP.Occur#/
s/#FinCheckQA is used in:[^#]*#/#FinCheckQA is used in:#/
s/#DetermineGrowthQA uses:[^#]*#/#DetermineGrowthQA uses: DetermineGrowthObs GBNP.CreateOccurTreeLR GBNP.Incr GBNP.LookUpOccurTreePTSLRPos GBNP.NumAlgGensNPmonList#/
s/#DetermineGrowthQA is used in:[^#]*#/#DetermineGrowthQA is used in:#/
s/#HilbertSeriesQA uses:[^#]*#/#HilbertSeriesQA uses: GBNP.CreateOccurTreeLR GBNP.FormalSum GBNP.LookUpOccurTreeForObsPTSLR GBNP.OccurInLstPTSLR#/
s/#HilbertSeriesQA is used in:[^#]*#/#HilbertSeriesQA is used in:#/
s/#GBNP.ConstantRow uses:[^#]*#/#GBNP.ConstantRow uses: GBNP.ConstantRow#/
s/#GBNP.ConstantRow is used in:[^#]*#/#GBNP.ConstantRow is used in: GBNP.ConstantRow GBNP.DetermineGrowthQA GBNP.IncidenceMatrix#/
s/#GBNP.IncidenceMatrix uses:[^#]*#/#GBNP.IncidenceMatrix uses: GBNP.ConstantRow#/
s/#GBNP.IncidenceMatrix is used in:[^#]*#/#GBNP.IncidenceMatrix is used in: DetermineGrowthObs#/
s/#GBNP.FormalSum uses:[^#]*#/#GBNP.FormalSum uses:#/
s/#GBNP.FormalSum is used in:[^#]*#/#GBNP.FormalSum is used in: HilbertSeriesG HilbertSeriesQA#/
s/#GraphOfNormalWords uses:[^#]*#/#GraphOfNormalWords uses: GBNP.CreateOccurTreeLR GBNP.OccurInLstPTSLR GBNP.SuffixOfTree#/
s/#GraphOfNormalWords is used in:[^#]*#/#GraphOfNormalWords is used in: DetermineGrowthObs#/
s/#GBNP.ReduceMatrix uses:[^#]*#/#GBNP.ReduceMatrix uses: GBNP.ReduceMatrix#/
s/#GBNP.ReduceMatrix is used in:[^#]*#/#GBNP.ReduceMatrix is used in: GBNP.DetermineGrowthQA GBNP.ReduceMatrix#/
s/#GBNP.DetermineGrowthQA uses:[^#]*#/#GBNP.DetermineGrowthQA uses: GBNP.ConstantRow GBNP.ReduceMatrix#/
s/#GBNP.DetermineGrowthQA is used in:[^#]*#/#GBNP.DetermineGrowthQA is used in: DetermineGrowthObs#/
s/#DetermineGrowthObs uses:[^#]*#/#DetermineGrowthObs uses: GBNP.DetermineGrowthQA GBNP.IncidenceMatrix GBNP.NumAlgGensNPmonList GraphOfNormalWords#/
s/#DetermineGrowthObs is used in:[^#]*#/#DetermineGrowthObs is used in: DetermineGrowthQA#/
s/#GraphOfChains uses:[^#]*#/#GraphOfChains uses: GBNP.CreateOccurTreeLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.OccurInLstPTSLR#/
s/#GraphOfChains is used in:[^#]*#/#GraphOfChains is used in:#/
s/#HilbertSeriesG uses:[^#]*#/#HilbertSeriesG uses: GBNP.FormalSum#/
s/#HilbertSeriesG is used in:[^#]*#/#HilbertSeriesG is used in:#/
s/#GBNP.RightOccur uses:[^#]*#/#GBNP.RightOccur uses: LtNP#/
s/#GBNP.RightOccur is used in:[^#]*#/#GBNP.RightOccur is used in: GBNP.RightOccurInLst#/
s/#GBNP.LeftOccur uses:[^#]*#/#GBNP.LeftOccur uses: LtNP#/
s/#GBNP.LeftOccur is used in:[^#]*#/#GBNP.LeftOccur is used in: GBNP.LeftObs GBNP.RightObs#/
s/#GBNP.Occur uses:[^#]*#/#GBNP.Occur uses: LtNP#/
s/#GBNP.Occur is used in:[^#]*#/#GBNP.Occur is used in: FinCheckQA GBNP.CentralT GBNP.CentralTrace GBNP.OccurInLst GBNP.ReducePol2 GBNP.ReducePolTrace2 GBNP.SGrobnerLoops#/
s/#GBNP.RightOccurInLst uses:[^#]*#/#GBNP.RightOccurInLst uses: GBNP.RightOccur#/
s/#GBNP.RightOccurInLst is used in:[^#]*#/#GBNP.RightOccurInLst is used in:#/
s/#GBNP.OccurInLst uses:[^#]*#/#GBNP.OccurInLst uses: GBNP.Occur#/
s/#GBNP.OccurInLst is used in:[^#]*#/#GBNP.OccurInLst is used in: GBNP.MakeArgumentLevel GBNP.NondivMonsByLevel GBNP.NondivMonsPTS GBNP.NondivMonsPTSenum GBNP.NormalForm2 GBNP.StrongNormalForm2 GBNP.StrongNormalFormTrace2#/
s/#GBNP.SelfObs uses:[^#]*#/#GBNP.SelfObs uses:#/
s/#GBNP.SelfObs is used in:[^#]*#/#GBNP.SelfObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#/
s/#GBNP.LeftObs uses:[^#]*#/#GBNP.LeftObs uses: GBNP.LeftOccur#/
s/#GBNP.LeftObs is used in:[^#]*#/#GBNP.LeftObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#/
s/#GBNP.RightObs uses:[^#]*#/#GBNP.RightObs uses: GBNP.LeftOccur#/
s/#GBNP.RightObs is used in:[^#]*#/#GBNP.RightObs is used in: GBNP.ObsTrace GBNP.ObsTrunc#/
s/#GBNP.Spoly uses:[^#]*#/#GBNP.Spoly uses: AddNP BimulNP#/
s/#GBNP.Spoly is used in:[^#]*#/#GBNP.Spoly is used in: GBNP.CentralT GBNP.ObsTall GBNP.ObsTrunc#/
s/#GBNP.NormalForm2 uses:[^#]*#/#GBNP.NormalForm2 uses: AddNP BimulNP GBNP.OccurInLst LMonsNP#/
s/#GBNP.NormalForm2 is used in:[^#]*#/#GBNP.NormalForm2 is used in: GBNP.NormalForm#/
s/#GBNP.NormalForm uses:[^#]*#/#GBNP.NormalForm uses: GBNP.NormalForm2#/
s/#GBNP.NormalForm is used in:[^#]*#/#GBNP.NormalForm is used in:#/
s/#GBNP.StrongNormalForm2 uses:[^#]*#/#GBNP.StrongNormalForm2 uses: AddNP BimulNP GBNP.OccurInLst LMonsNP#/
s/#GBNP.StrongNormalForm2 is used in:[^#]*#/#GBNP.StrongNormalForm2 is used in: GBNP.ObsTrunc StrongNormalFormNP StrongNormalFormNPM#/
s/#StrongNormalFormNP uses:[^#]*#/#StrongNormalFormNP uses: CleanNP GBNP.StrongNormalForm2 MkMonicNP#/
s/#StrongNormalFormNP is used in:[^#]*#/#StrongNormalFormNP is used in: MulQA#/
s/#GBNP.ReducePol2 uses:[^#]*#/#GBNP.ReducePol2 uses: GBNP.AddMonToTreePTSLR GBNP.CalculatePGlts GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.Occur GBNP.ReduceCancellation GBNP.RemoveMonFromTreePTSLR GBNP.StrongNormalForm2TS LMonsNP LtNP MkMonicNP#/
s/#GBNP.ReducePol2 is used in:[^#]*#/#GBNP.ReducePol2 is used in: GBNP.AllObsTrunc GBNP.ReducePol GBNP.SGrobnerTruncLevel SGrobner#/
s/#GBNP.ReducePol uses:[^#]*#/#GBNP.ReducePol uses: CleanNP GBNP.ReducePol2 MkMonicNP#/
s/#GBNP.ReducePol is used in:[^#]*#/#GBNP.ReducePol is used in: GBNP.SGrobnerTrunc GBNP.SGrobnerTruncLevel Grobner SGrobner#/
s/#GBNP.AllObs uses:[^#]*#/#GBNP.AllObs uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.ObsTall GBNP.StrongNormalFormTall LMonsNP#/
s/#GBNP.AllObs is used in:[^#]*#/#GBNP.AllObs is used in: GBNP.IsGrobnerBasisTest Grobner IsGrobnerPair MakeGrobnerPair SGrobner#/
s/#Grobner uses:[^#]*#/#Grobner uses: GBNP.AllObs GBNP.CalculatePG GBNP.ReducePol GBNP.SGrobnerLoops#/
s/#Grobner is used in:[^#]*#/#Grobner is used in:#/
s/#SGrobner uses:[^#]*#/#SGrobner uses: GBNP.AllObs GBNP.CalculatePG GBNP.ReducePol GBNP.ReducePol2 GBNP.ReducePolTails GBNP.SGrobnerLoops#/
s/#SGrobner is used in:[^#]*#/#SGrobner is used in: SGrobnerModule#/
s/#BaseQA uses:[^#]*#/#BaseQA uses: GBNP.NondivMons LMonsNP#/
s/#BaseQA is used in:[^#]*#/#BaseQA is used in:#/
s/#DimQA uses:[^#]*#/#DimQA uses: GBNP.NondivMonsPTSenum LMonsNP#/
s/#DimQA is used in:[^#]*#/#DimQA is used in:#/
s/#MulQA uses:[^#]*#/#MulQA uses: MulNP StrongNormalFormNP#/
s/#MulQA is used in:[^#]*#/#MulQA is used in: MatrixQA#/
s/#GBNP.StrongNormalForm2TS uses:[^#]*#/#GBNP.StrongNormalForm2TS uses: AddNP BimulNP GBNP.LookUpOccurTreeAllLstPTSLR#/
s/#GBNP.StrongNormalForm2TS is used in:[^#]*#/#GBNP.StrongNormalForm2TS is used in: GBNP.ReducePol2 GBNP.ReducePolTails#/
s/#GBNP.NormalForm2T uses:[^#]*#/#GBNP.NormalForm2T uses: AddNP BimulNP GBNP.OccurInLstT#/
s/#GBNP.NormalForm2T is used in:[^#]*#/#GBNP.NormalForm2T is used in:#/
s/#GBNP.CentralT uses:[^#]*#/#GBNP.CentralT uses: GBNP.AddMonToTreePTSLR GBNP.Occur GBNP.Spoly GBNP.StrongNormalForm2Tall LMonsNP MkMonicNP#/
s/#GBNP.CentralT is used in:[^#]*#/#GBNP.CentralT is used in:#/
s/#GBNP.LeftObsT uses:[^#]*#/#GBNP.LeftObsT uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.LookUpOccurTreePTSLRPos LtNP#/
s/#GBNP.LeftObsT is used in:[^#]*#/#GBNP.LeftObsT is used in: GBNP.ObsTall#/
s/#GBNP.RightObsT uses:[^#]*#/#GBNP.RightObsT uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreeForObsPTSLR GBNP.LookUpOccurTreePTSLRPos LtNP#/
s/#GBNP.RightObsT is used in:[^#]*#/#GBNP.RightObsT is used in: GBNP.ObsTall#/
s/#IsStrongGrobnerBasis uses:[^#]*#/#IsStrongGrobnerBasis uses: GBNP.IsGrobnerBasisTest#/
s/#IsStrongGrobnerBasis is used in:[^#]*#/#IsStrongGrobnerBasis is used in:#/
s/#IsGrobnerBasis uses:[^#]*#/#IsGrobnerBasis uses: GBNP.IsGrobnerBasisTest#/
s/#IsGrobnerBasis is used in:[^#]*#/#IsGrobnerBasis is used in:#/
s/#GBNP.IsGrobnerBasisTest uses:[^#]*#/#GBNP.IsGrobnerBasisTest uses: AddNP CleanNP GBNP.AddMonToTreePTSLR GBNP.AllObs GBNP.CalculatePG GBNP.CreateOccurTreePTSLR GBNP.StrongNormalFormTall LMonsNP LtNP MkMonicNP#/
s/#GBNP.IsGrobnerBasisTest is used in:[^#]*#/#GBNP.IsGrobnerBasisTest is used in: IsGrobnerBasis IsStrongGrobnerBasis#/
s/#IsGrobnerPair uses:[^#]*#/#IsGrobnerPair uses: CleanNP GBNP.AllObs GBNP.CalculatePG GBNP.CreateOccurTreePTSLR GBNP.OccurInLstPTSLR GBNP.StrongNormalForm2Tall GBNP.StrongNormalFormTall LMonsNP MkMonicNP#/
s/#IsGrobnerPair is used in:[^#]*#/#IsGrobnerPair is used in:#/
s/#GBNP.MakeGrobnerPairMakeMonic uses:[^#]*#/#GBNP.MakeGrobnerPairMakeMonic uses: CleanNP MkMonicNP#/
s/#GBNP.MakeGrobnerPairMakeMonic is used in:[^#]*#/#GBNP.MakeGrobnerPairMakeMonic is used in: MakeGrobnerPair#/
s/#MakeGrobnerPair uses:[^#]*#/#MakeGrobnerPair uses: GBNP.AddMonToTreePTSLR GBNP.AllObs GBNP.CalculatePG GBNP.CreateOccurTreePTSLR GBNP.MakeGrobnerPairMakeMonic GBNP.OccurInLstPTSLR GBNP.StrongNormalForm2Tall GBNP.StrongNormalFormTall LMonsNP#/
s/#MakeGrobnerPair is used in:[^#]*#/#MakeGrobnerPair is used in:#/
s/#StrongNormalFormNPM uses:[^#]*#/#StrongNormalFormNPM uses: GBNP.StrongNormalForm2#/
s/#StrongNormalFormNPM is used in:[^#]*#/#StrongNormalFormNPM is used in: MulQM#/
s/#SGrobnerModule uses:[^#]*#/#SGrobnerModule uses: GBNP.CalculatePG GBNP.GetOptions GBNP.SetOption MulNP SGrobner#/
s/#SGrobnerModule is used in:[^#]*#/#SGrobnerModule is used in:#/
s/#MulQM uses:[^#]*#/#MulQM uses: MulNP StrongNormalFormNPM#/
s/#MulQM is used in:[^#]*#/#MulQM is used in: MatrixQA#/
s/#BaseQM uses:[^#]*#/#BaseQM uses: GBNP.NondivMonsPTS LMonsNP#/
s/#BaseQM is used in:[^#]*#/#BaseQM is used in:#/
s/#DimQM uses:[^#]*#/#DimQM uses: GBNP.NondivMonsPTSenum LMonsNP#/
s/#DimQM is used in:[^#]*#/#DimQM is used in:#/
s/#GBNP.SGrobnerLoops uses:[^#]*#/#GBNP.SGrobnerLoops uses: GBNP.AddMonToTreePTSLR GBNP.CreateOccurTreePTSLR GBNP.Find3Dnum GBNP.GetOptions GBNP.LookUpOccurTreeAllLstPTSLR GBNP.NondivMonsPTSenum GBNP.ObsTall GBNP.Occur GBNP.OccurInLstT GBNP.ReducePolTailsPTS GBNP.RemoveMonFromTreePTSLR GBNP.SetOption GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall LMonsNP MkMonicNP THeapOT#/
s/#GBNP.SGrobnerLoops is used in:[^#]*#/#GBNP.SGrobnerLoops is used in: GBNP.GrobnerLoop GBNP.GrobnerLoopAll GBNP.SGrobnerLoop GBNP.SGrobnerTruncLoop Grobner SGrobner#/
s/#GBNP.SGrobnerLoop uses:[^#]*#/#GBNP.SGrobnerLoop uses: GBNP.SGrobnerLoops#/
s/#GBNP.SGrobnerLoop is used in:[^#]*#/#GBNP.SGrobnerLoop is used in:#/
s/#GBNP.GrobnerLoop uses:[^#]*#/#GBNP.GrobnerLoop uses: GBNP.SGrobnerLoops#/
s/#GBNP.GrobnerLoop is used in:[^#]*#/#GBNP.GrobnerLoop is used in:#/
s/#GBNP.SGrobnerTruncLoop uses:[^#]*#/#GBNP.SGrobnerTruncLoop uses: GBNP.SGrobnerLoops#/
s/#GBNP.SGrobnerTruncLoop is used in:[^#]*#/#GBNP.SGrobnerTruncLoop is used in: GBNP.SGrobnerTruncLevel#/
s/#GBNP.GrobnerLoopAll uses:[^#]*#/#GBNP.GrobnerLoopAll uses: GBNP.SGrobnerLoops#/
s/#GBNP.GrobnerLoopAll is used in:[^#]*#/#GBNP.GrobnerLoopAll is used in:#/
s/#GBNP.SGrobnerTraceLoop uses:[^#]*#/#GBNP.SGrobnerTraceLoop uses: GBNP.CentralTrace GBNP.MkMonicNPTrace GBNP.ObsTrace GBNP.StrongNormalFormTrace2#/
s/#GBNP.SGrobnerTraceLoop is used in:[^#]*#/#GBNP.SGrobnerTraceLoop is used in: SGrobnerTrace#/
s/#GBNP.ObsTall uses:[^#]*#/#GBNP.ObsTall uses: GBNP.AddMonToTreePTSLR GBNP.LeftObsT GBNP.RightObsT GBNP.SortParallelOT GBNP.Spoly GBNP.StrongNormalForm2Tall GBNP.WeightedDegreeMon LMonsNP MkMonicNP#/
s/#GBNP.ObsTall is used in:[^#]*#/#GBNP.ObsTall is used in: GBNP.AllObs GBNP.SGrobnerLoops#/
s/#GBNP.StrongNormalFormTall uses:[^#]*#/#GBNP.StrongNormalFormTall uses: GBNP.CreateOccurTreePTSLR GBNP.StrongNormalForm2Tall#/
s/#GBNP.StrongNormalFormTall is used in:[^#]*#/#GBNP.StrongNormalFormTall is used in: GBNP.AllObs GBNP.IsGrobnerBasisTest IsGrobnerPair MakeGrobnerPair#/
s/#GBNP.StrongNormalForm2Tall uses:[^#]*#/#GBNP.StrongNormalForm2Tall uses: AddNP BimulNP GBNP.OccurInLstT GBNP.ReduceCancellation#/
s/#GBNP.StrongNormalForm2Tall is used in:[^#]*#/#GBNP.StrongNormalForm2Tall is used in: GBNP.CentralT GBNP.ObsTall GBNP.SGrobnerLoops GBNP.StrongNormalFormTall IsGrobnerPair MakeGrobnerPair#/
s/#GBNP.StrongNormalForm3Dall uses:[^#]*#/#GBNP.StrongNormalForm3Dall uses: AddNP BimulNP GBNP.Find3Dnum GBNP.LookUpOccurTreeAllLstPTSLR GBNP.OccurInLstT GBNP.ReduceCancellation#/
s/#GBNP.StrongNormalForm3Dall is used in:[^#]*#/#GBNP.StrongNormalForm3Dall is used in: GBNP.SGrobnerLoops#/
s/#GBNP.StrongNormalForm2TSPTS uses:[^#]*#/#GBNP.StrongNormalForm2TSPTS uses: AddNP BimulNP GBNP.LookUpOccurTreeAllLstPTSLR#/
s/#GBNP.StrongNormalForm2TSPTS is used in:[^#]*#/#GBNP.StrongNormalForm2TSPTS is used in: GBNP.ReducePolTailsPTS#/
s/#GBNP.ReducePolTails uses:[^#]*#/#GBNP.ReducePolTails uses: GBNP.StrongNormalForm2TS#/
s/#GBNP.ReducePolTails is used in:[^#]*#/#GBNP.ReducePolTails is used in: SGrobner#/
s/#GBNP.ReducePolTailsPTS uses:[^#]*#/#GBNP.ReducePolTailsPTS uses: GBNP.StrongNormalForm2TSPTS#/
s/#GBNP.ReducePolTailsPTS is used in:[^#]*#/#GBNP.ReducePolTailsPTS is used in: GBNP.SGrobnerLoops#/
s/#GBNP.ReduceCancellation uses:[^#]*#/#GBNP.ReduceCancellation uses: GBNP.GetOptions#/
s/#GBNP.ReduceCancellation is used in:[^#]*#/#GBNP.ReduceCancellation is used in: GBNP.ReducePol2 GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall#/
s/#GBNP.Find3Dnum uses:[^#]*#/#GBNP.Find3Dnum uses:#/
s/#GBNP.Find3Dnum is used in:[^#]*#/#GBNP.Find3Dnum is used in: GBNP.SGrobnerLoops GBNP.StrongNormalForm3Dall#/
s/#THeapOT uses:[^#]*#/#THeapOT uses: GBNP.AddMonToTreePTSLR GBNP.RemoveMonFromTreePTSLR GBNP.SortParallelOT GBNP.THeapOTBalanceDown GBNP.THeapOTBalanceUp GBNP.THeapOTGetParentIndex GBNP.THeapOTSwap LMonsNP LtNP#/
s/#THeapOT is used in:[^#]*#/#THeapOT is used in: GBNP.SGrobnerLoops#/
s/#GBNP.THeapOTBalanceDown uses:[^#]*#/#GBNP.THeapOTBalanceDown uses: GBNP.THeapOTGetChildrenIndex GBNP.THeapOTSwap LtNP#/
s/#GBNP.THeapOTBalanceDown is used in:[^#]*#/#GBNP.THeapOTBalanceDown is used in: THeapOT#/
s/#GBNP.THeapOTBalanceUp uses:[^#]*#/#GBNP.THeapOTBalanceUp uses: GBNP.THeapOTGetParentIndex GBNP.THeapOTSwap LtNP#/
s/#GBNP.THeapOTBalanceUp is used in:[^#]*#/#GBNP.THeapOTBalanceUp is used in: THeapOT#/
s/#GBNP.THeapOTGetChildrenIndex uses:[^#]*#/#GBNP.THeapOTGetChildrenIndex uses:#/
s/#GBNP.THeapOTGetChildrenIndex is used in:[^#]*#/#GBNP.THeapOTGetChildrenIndex is used in: GBNP.THeapOTBalanceDown#/
s/#GBNP.THeapOTGetParentIndex uses:[^#]*#/#GBNP.THeapOTGetParentIndex uses:#/
s/#GBNP.THeapOTGetParentIndex is used in:[^#]*#/#GBNP.THeapOTGetParentIndex is used in: GBNP.THeapOTBalanceUp THeapOT#/
s/#GBNP.THeapOTSwap uses:[^#]*#/#GBNP.THeapOTSwap uses:#/
s/#GBNP.THeapOTSwap is used in:[^#]*#/#GBNP.THeapOTSwap is used in: GBNP.THeapOTBalanceDown GBNP.THeapOTBalanceUp THeapOT#/
s/#GBNP.THeapOTCheck uses:[^#]*#/#GBNP.THeapOTCheck uses: GBNP.OccurInLstT LtNP#/
s/#GBNP.THeapOTCheck is used in:[^#]*#/#GBNP.THeapOTCheck is used in:#/
s/#AddNP uses:[^#]*#/#AddNP uses: LtNP#/
s/#AddNP is used in:[^#]*#/#AddNP is used in: EvalTrace GBNP.GP2NPM GBNP.IsGrobnerBasisTest GBNP.NormalForm2 GBNP.NormalForm2T GBNP.Spoly GBNP.SpolyTrace GBNP.StrongNormalForm2 GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.StrongNormalFormTrace2 GBNP.TraceNP StrongNormalFormTraceDiff#/
s/#LtNP uses:[^#]*#/#LtNP uses:#/
s/#LtNP is used in:[^#]*#/#LtNP is used in: AddNP GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.LeftOccur GBNP.Occur GBNP.ReducePol2 GBNP.ReducePolTrace2 GBNP.RightObsT GBNP.RightOccur GBNP.THeapOTBalanceDown GBNP.THeapOTBalanceUp GBNP.THeapOTCheck THeapOT#/
s/#GtNP uses:[^#]*#/#GtNP uses:#/
s/#GtNP is used in:[^#]*#/#GtNP is used in:#/
s/#LMonsNP uses:[^#]*#/#LMonsNP uses:#/
s/#LMonsNP is used in:[^#]*#/#LMonsNP is used in: BaseQA BaseQM DimQA DimQM GBNP.AllObs GBNP.AllObsTrunc GBNP.CentralT GBNP.CheckHom GBNP.IsGrobnerBasisTest GBNP.NormalForm2 GBNP.ObsTall GBNP.ObsTrunc GBNP.ReducePol2 GBNP.SGrobnerLoops GBNP.SGrobnerTrunc GBNP.StrongNormalForm2 IsGrobnerPair MakeGrobnerPair THeapOT#/
s/#CleanNP uses:[^#]*#/#CleanNP uses:#/
s/#CleanNP is used in:[^#]*#/#CleanNP is used in: CheckHomogeneousNPs EvalTrace GBNP.GP2NPM GBNP.IsGrobnerBasisTest GBNP.MakeGrobnerPairMakeMonic GBNP.NPArray2NPM GBNP.ReducePol GBNP.ReducePolTrace GP2NP IsGrobnerPair MulNP StrongNormalFormNP#/
s/#MkMonicNP uses:[^#]*#/#MkMonicNP uses:#/
s/#MkMonicNP is used in:[^#]*#/#MkMonicNP is used in: GBNP.CentralT GBNP.IsGrobnerBasisTest GBNP.MakeGrobnerPairMakeMonic GBNP.ObsTall GBNP.ObsTrunc GBNP.ReducePol GBNP.ReducePol2 GBNP.SGrobnerLoops IsGrobnerPair StrongNormalFormNP#/
s/#BimulNP uses:[^#]*#/#BimulNP uses:#/
s/#BimulNP is used in:[^#]*#/#BimulNP is used in: EvalTrace GBNP.NormalForm2 GBNP.NormalForm2T GBNP.Spoly GBNP.SpolyTrace GBNP.StrongNormalForm2 GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.StrongNormalFormTrace2 GBNP.TraceNP#/
s/#MulNP uses:[^#]*#/#MulNP uses: CleanNP#/
s/#MulNP is used in:[^#]*#/#MulNP is used in: MulQA MulQM SGrobnerModule#/
s/#GBNP.LTermsTrace uses:[^#]*#/#GBNP.LTermsTrace uses:#/
s/#GBNP.LTermsTrace is used in:[^#]*#/#GBNP.LTermsTrace is used in: GBNP.AllObsTrace GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTrace2 GBNP.StrongNormalFormTrace2#/
s/#GBNP.MkMonicNPTrace uses:[^#]*#/#GBNP.MkMonicNPTrace uses:#/
s/#GBNP.MkMonicNPTrace is used in:[^#]*#/#GBNP.MkMonicNPTrace is used in: GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop#/
s/#GBNP.AddTrace uses:[^#]*#/#GBNP.AddTrace uses:#/
s/#GBNP.AddTrace is used in:[^#]*#/#GBNP.AddTrace is used in: GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#/
s/#GBNP.TraceNP uses:[^#]*#/#GBNP.TraceNP uses: AddNP BimulNP GBNP.TraceNP#/
s/#GBNP.TraceNP is used in:[^#]*#/#GBNP.TraceNP is used in: GBNP.TraceNP#/
s/#GBNP.Traced uses:[^#]*#/#GBNP.Traced uses:#/
s/#GBNP.Traced is used in:[^#]*#/#GBNP.Traced is used in: GBNP.ReducePolTrace#/
s/#GBNP.IsNPMNotZero uses:[^#]*#/#GBNP.IsNPMNotZero uses:#/
s/#GBNP.IsNPMNotZero is used in:[^#]*#/#GBNP.IsNPMNotZero is used in: GBNP.NPM2NPArray#/
s/#GBNP.MaximumZ uses:[^#]*#/#GBNP.MaximumZ uses:#/
s/#GBNP.MaximumZ is used in:[^#]*#/#GBNP.MaximumZ is used in: GBNP.NumAlgGensNPmon GBNP.NumAlgGensNPmonList GBNP.NumModGensNPmonList NumAlgGensNP NumAlgGensNPList NumModGensNPList#/
s/#NumAlgGensNP uses:[^#]*#/#NumAlgGensNP uses: GBNP.MaximumZ#/
s/#NumAlgGensNP is used in:[^#]*#/#NumAlgGensNP is used in: NumAlgGensNPList#/
s/#NumAlgGensNPList uses:[^#]*#/#NumAlgGensNPList uses: GBNP.MaximumZ NumAlgGensNP#/
s/#NumAlgGensNPList is used in:[^#]*#/#NumAlgGensNPList is used in:#/
s/#GBNP.NumAlgGensNPmon uses:[^#]*#/#GBNP.NumAlgGensNPmon uses: GBNP.MaximumZ#/
s/#GBNP.NumAlgGensNPmon is used in:[^#]*#/#GBNP.NumAlgGensNPmon is used in:#/
s/#GBNP.NumAlgGensNPmonList uses:[^#]*#/#GBNP.NumAlgGensNPmonList uses: GBNP.MaximumZ#/
s/#GBNP.NumAlgGensNPmonList is used in:[^#]*#/#GBNP.NumAlgGensNPmonList is used in: DetermineGrowthObs DetermineGrowthQA#/
s/#GBNP.MinimumZ uses:[^#]*#/#GBNP.MinimumZ uses:#/
s/#GBNP.MinimumZ is used in:[^#]*#/#GBNP.MinimumZ is used in: GBNP.NumModGensNPmon NumModGensNP#/
s/#NumModGensNP uses:[^#]*#/#NumModGensNP uses: GBNP.MinimumZ#/
s/#NumModGensNP is used in:[^#]*#/#NumModGensNP is used in: NumModGensNPList#/
s/#NumModGensNPList uses:[^#]*#/#NumModGensNPList uses: GBNP.MaximumZ NumModGensNP#/
s/#NumModGensNPList is used in:[^#]*#/#NumModGensNPList is used in:#/
s/#GBNP.NumModGensNPmon uses:[^#]*#/#GBNP.NumModGensNPmon uses: GBNP.MinimumZ#/
s/#GBNP.NumModGensNPmon is used in:[^#]*#/#GBNP.NumModGensNPmon is used in:#/
s/#GBNP.NumModGensNPmonList uses:[^#]*#/#GBNP.NumModGensNPmonList uses: GBNP.MaximumZ#/
s/#GBNP.NumModGensNPmonList is used in:[^#]*#/#GBNP.NumModGensNPmonList is used in:#/
s/#GBNP.Coefs uses:[^#]*#/#GBNP.Coefs uses:#/
s/#GBNP.Coefs is used in:[^#]*#/#GBNP.Coefs is used in: GBNP.GP2NPM GP2NP#/
s/#GBNP.Mons uses:[^#]*#/#GBNP.Mons uses:#/
s/#GBNP.Mons is used in:[^#]*#/#GBNP.Mons is used in: GBNP.GP2NPM GP2NP#/
s/#GP2NP uses:[^#]*#/#GP2NP uses: CleanNP GBNP.Coefs GBNP.GP2NPM GBNP.Mons#/
s/#GP2NP is used in:[^#]*#/#GP2NP is used in: GBNP.AddGP2NPList GP2NPList#/
s/#GP2NPList uses:[^#]*#/#GP2NPList uses: GP2NP#/
s/#GP2NPList is used in:[^#]*#/#GP2NPList is used in:#/
s/#GBNP.AddGP2NPList uses:[^#]*#/#GBNP.AddGP2NPList uses: GP2NP#/
s/#GBNP.AddGP2NPList is used in:[^#]*#/#GBNP.AddGP2NPList is used in:#/
s/#NP2GP uses:[^#]*#/#NP2GP uses: GBNP.NPM2GP#/
s/#NP2GP is used in:[^#]*#/#NP2GP is used in: NP2GPList wordfun#/
s/#NP2GPList uses:[^#]*#/#NP2GPList uses: NP2GP#/
s/#NP2GPList is used in:[^#]*#/#NP2GPList is used in:#/
s/#GBNP.NPM2NPArray uses:[^#]*#/#GBNP.NPM2NPArray uses: GBNP.IsNPMNotZero#/
s/#GBNP.NPM2NPArray is used in:[^#]*#/#GBNP.NPM2NPArray is used in: GBNP.PrintNPM#/
s/#GBNP.NPArray2NPM uses:[^#]*#/#GBNP.NPArray2NPM uses: CleanNP#/
s/#GBNP.NPArray2NPM is used in:[^#]*#/#GBNP.NPArray2NPM is used in:#/
s/#GBNP.GP2NPM uses:[^#]*#/#GBNP.GP2NPM uses: AddNP CleanNP GBNP.Coefs GBNP.GetOptions GBNP.Mons GBNP.SetOption#/
s/#GBNP.GP2NPM is used in:[^#]*#/#GBNP.GP2NPM is used in: GP2NP#/
s/#GBNP.NPM2GP uses:[^#]*#/#GBNP.NPM2GP uses:#/
s/#GBNP.NPM2GP is used in:[^#]*#/#GBNP.NPM2GP is used in: NP2GP#/
s/#GBNP.SplitNP uses:[^#]*#/#GBNP.SplitNP uses:#/
s/#GBNP.SplitNP is used in:[^#]*#/#GBNP.SplitNP is used in: MatrixQA#/
s/#MatrixQA uses:[^#]*#/#MatrixQA uses: GBNP.SplitNP MulQA MulQM#/
s/#MatrixQA is used in:[^#]*#/#MatrixQA is used in: MatricesQA MatrixQAC#/
s/#MatricesQA uses:[^#]*#/#MatricesQA uses: MatrixQA#/
s/#MatricesQA is used in:[^#]*#/#MatricesQA is used in:#/
s/#MatrixQAC uses:[^#]*#/#MatrixQAC uses: MatrixQA#/
s/#MatrixQAC is used in:[^#]*#/#MatrixQAC is used in: MatricesQAC#/
s/#MatricesQAC uses:[^#]*#/#MatricesQAC uses: MatrixQAC#/
s/#MatricesQAC is used in:[^#]*#/#MatricesQAC is used in:#/
s/#GBNP.CreateOccurTreePTSLRimpl uses:[^#]*#/#GBNP.CreateOccurTreePTSLRimpl uses: GBNP.AddMonToTreePTSLR#/
s/#GBNP.CreateOccurTreePTSLRimpl is used in:[^#]*#/#GBNP.CreateOccurTreePTSLRimpl is used in: GBNP.CreateOccurTreeLR GBNP.CreateOccurTreePTSLR#/
s/#GBNP.CreateOccurTreeLR uses:[^#]*#/#GBNP.CreateOccurTreeLR uses: GBNP.CreateOccurTreePTSLRimpl#/
s/#GBNP.CreateOccurTreeLR is used in:[^#]*#/#GBNP.CreateOccurTreeLR is used in: DetermineGrowthQA FinCheckQA GBNP.RedAddToTree GraphOfChains GraphOfNormalWords HilbertSeriesQA#/
s/#GBNP.CreateOccurTreePTSLR uses:[^#]*#/#GBNP.CreateOccurTreePTSLR uses: GBNP.CreateOccurTreePTSLRimpl GBNP.GetOptions#/
s/#GBNP.CreateOccurTreePTSLR is used in:[^#]*#/#GBNP.CreateOccurTreePTSLR is used in: GBNP.AllObs GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.NondivMonsPTS GBNP.NondivMonsPTSenum GBNP.ReducePol2 GBNP.RightObsT GBNP.SGrobnerLoops GBNP.StrongNormalFormTall IsGrobnerPair MakeGrobnerPair#/
s/#GBNP.LookUpOccurTreeAllPTSLRPos uses:[^#]*#/#GBNP.LookUpOccurTreeAllPTSLRPos uses:#/
s/#GBNP.LookUpOccurTreeAllPTSLRPos is used in:[^#]*#/#GBNP.LookUpOccurTreeAllPTSLRPos is used in: GBNP.LookUpOccurTreeAllLstPTSLR#/
s/#GBNP.LookUpOccurTreePTSLRPos uses:[^#]*#/#GBNP.LookUpOccurTreePTSLRPos uses:#/
s/#GBNP.LookUpOccurTreePTSLRPos is used in:[^#]*#/#GBNP.LookUpOccurTreePTSLRPos is used in: DetermineGrowthQA FinCheckQA GBNP.LeftObsT GBNP.NondivMonsPTS GBNP.OccurInLstPTSLR GBNP.OccurLeftInLstT GBNP.RightObsT countfun#/
s/#GBNP.OccurInLstT uses:[^#]*#/#GBNP.OccurInLstT uses: GBNP.OccurInLstPTSLR#/
s/#GBNP.OccurInLstT is used in:[^#]*#/#GBNP.OccurInLstT is used in: GBNP.NormalForm2T GBNP.SGrobnerLoops GBNP.StrongNormalForm2Tall GBNP.StrongNormalForm3Dall GBNP.THeapOTCheck#/
s/#GBNP.OccurInLstPTSLR uses:[^#]*#/#GBNP.OccurInLstPTSLR uses: GBNP.LookUpOccurTreePTSLRPos#/
s/#GBNP.OccurInLstPTSLR is used in:[^#]*#/#GBNP.OccurInLstPTSLR is used in: GBNP.OccurInLstT GraphOfChains GraphOfNormalWords HilbertSeriesQA IsGrobnerPair MakeGrobnerPair#/
s/#GBNP.OccurLeftInLstT uses:[^#]*#/#GBNP.OccurLeftInLstT uses: GBNP.LookUpOccurTreePTSLRPos#/
s/#GBNP.OccurLeftInLstT is used in:[^#]*#/#GBNP.OccurLeftInLstT is used in:#/
s/#GBNP.LookUpOccurTreeAllLstPTSLR uses:[^#]*#/#GBNP.LookUpOccurTreeAllLstPTSLR uses: GBNP.LookUpOccurTreeAllPTSLRPos#/
s/#GBNP.LookUpOccurTreeAllLstPTSLR is used in:[^#]*#/#GBNP.LookUpOccurTreeAllLstPTSLR is used in: GBNP.SGrobnerLoops GBNP.StrongNormalForm2TS GBNP.StrongNormalForm2TSPTS GBNP.StrongNormalForm3Dall#/
s/#GBNP.LookUpOccurTreeForObsPTSLRPos uses:[^#]*#/#GBNP.LookUpOccurTreeForObsPTSLRPos uses:#/
s/#GBNP.LookUpOccurTreeForObsPTSLRPos is used in:[^#]*#/#GBNP.LookUpOccurTreeForObsPTSLRPos is used in: GBNP.LookUpOccurTreeForObsPTSLR#/
s/#GBNP.LookUpOccurTreeForObsPTSLR uses:[^#]*#/#GBNP.LookUpOccurTreeForObsPTSLR uses: GBNP.LookUpOccurTreeForObsPTSLRPos#/
s/#GBNP.LookUpOccurTreeForObsPTSLR is used in:[^#]*#/#GBNP.LookUpOccurTreeForObsPTSLR is used in: GBNP.LeftObsT GBNP.RightObsT GraphOfChains HilbertSeriesQA#/
s/#GBNP.AddMonToTreePTSLR uses:[^#]*#/#GBNP.AddMonToTreePTSLR uses:#/
s/#GBNP.AddMonToTreePTSLR is used in:[^#]*#/#GBNP.AddMonToTreePTSLR is used in: GBNP.AllObs GBNP.CentralT GBNP.CreateOccurTreePTSLRimpl GBNP.IsGrobnerBasisTest GBNP.LeftObsT GBNP.ObsTall GBNP.ReducePol2 GBNP.RightObsT GBNP.SGrobnerLoops MakeGrobnerPair THeapOT#/
s/#GBNP.RemoveMonFromTreePTSLR uses:[^#]*#/#GBNP.RemoveMonFromTreePTSLR uses:#/
s/#GBNP.RemoveMonFromTreePTSLR is used in:[^#]*#/#GBNP.RemoveMonFromTreePTSLR is used in: GBNP.ReducePol2 GBNP.SGrobnerLoops THeapOT#/
s/#GBNP.SortParallelOT uses:[^#]*#/#GBNP.SortParallelOT uses:#/
s/#GBNP.SortParallelOT is used in:[^#]*#/#GBNP.SortParallelOT is used in: GBNP.ObsTall THeapOT#/
s/#GBNP.NondivMons uses:[^#]*#/#GBNP.NondivMons uses: GBNP.NondivMonsPTS#/
s/#GBNP.NondivMons is used in:[^#]*#/#GBNP.NondivMons is used in: BaseQA#/
s/#GBNP.NondivMonsPTS uses:[^#]*#/#GBNP.NondivMonsPTS uses: GBNP.CreateOccurTreePTSLR GBNP.LookUpOccurTreePTSLRPos GBNP.OccurInLst#/
s/#GBNP.NondivMonsPTS is used in:[^#]*#/#GBNP.NondivMonsPTS is used in: BaseQM GBNP.NondivMons#/
s/#GBNP.NondivMonsPTSenum uses:[^#]*#/#GBNP.NondivMonsPTSenum uses: GBNP.CreateOccurTreePTSLR GBNP.GetOptions GBNP.OccurInLst#/
s/#GBNP.NondivMonsPTSenum is used in:[^#]*#/#GBNP.NondivMonsPTSenum is used in: DimQA DimQM GBNP.SGrobnerLoops#/
s/#countfun uses:[^#]*#/#countfun uses: GBNP.LookUpOccurTreePTSLRPos countfun#/
s/#countfun is used in:[^#]*#/#countfun is used in: countfun#/
s/#GBNP.GetOptions uses:[^#]*#/#GBNP.GetOptions uses:#/
s/#GBNP.GetOptions is used in:[^#]*#/#GBNP.GetOptions is used in: GBNP.AllObs GBNP.CreateOccurTreePTSLR GBNP.GP2NPM GBNP.NondivMonsPTSenum GBNP.PrintTraceTerm GBNP.ReduceCancellation GBNP.ReduceCancellationTrace GBNP.ReducePol2 GBNP.SGrobnerLoops GBNP.TransLetter PrintNP SGrobnerModule#/
s/#GBNP.GetOption uses:[^#]*#/#GBNP.GetOption uses:#/
s/#GBNP.GetOption is used in:[^#]*#/#GBNP.GetOption is used in:#/
s/#GBNP.SetOptions uses:[^#]*#/#GBNP.SetOptions uses:#/
s/#GBNP.SetOptions is used in:[^#]*#/#GBNP.SetOptions is used in:#/
s/#GBNP.SetOption uses:[^#]*#/#GBNP.SetOption uses:#/
s/#GBNP.SetOption is used in:[^#]*#/#GBNP.SetOption is used in: GBNP.ConfigPrint GBNP.GP2NPM GBNP.SGrobnerLoops SGrobnerModule#/
s/#GBNP.ClearOptions uses:[^#]*#/#GBNP.ClearOptions uses:#/
s/#GBNP.ClearOptions is used in:[^#]*#/#GBNP.ClearOptions is used in:#/
s/#GBNP.ClearOption uses:[^#]*#/#GBNP.ClearOption uses:#/
s/#GBNP.ClearOption is used in:[^#]*#/#GBNP.ClearOption is used in:#/
s/#GBNP.ConfigPrint uses:[^#]*#/#GBNP.ConfigPrint uses: GBNP.SetOption#/
s/#GBNP.ConfigPrint is used in:[^#]*#/#GBNP.ConfigPrint is used in:#/
s/#GBNP.CalculatePG uses:[^#]*#/#GBNP.CalculatePG uses:#/
s/#GBNP.CalculatePG is used in:[^#]*#/#GBNP.CalculatePG is used in: GBNP.IsGrobnerBasisTest Grobner IsGrobnerPair MakeGrobnerPair SGrobner SGrobnerModule#/
s/#GBNP.CalculatePGlts uses:[^#]*#/#GBNP.CalculatePGlts uses:#/
s/#GBNP.CalculatePGlts is used in:[^#]*#/#GBNP.CalculatePGlts is used in: GBNP.ReducePol2#/
s/#PrintNP uses:[^#]*#/#PrintNP uses: GBNP.GetOptions GBNP.PrintNPM GBNP.TransWord#/
s/#PrintNP is used in:[^#]*#/#PrintNP is used in: PrintNPList#/
s/#PrintNPList uses:[^#]*#/#PrintNPList uses: PrintNP#/
s/#PrintNPList is used in:[^#]*#/#PrintNPList is used in: PrintNPListTrace#/
s/#GBNP.PrintNPnonewline uses:[^#]*#/#GBNP.PrintNPnonewline uses: GBNP.TransWord#/
s/#GBNP.PrintNPnonewline is used in:[^#]*#/#GBNP.PrintNPnonewline is used in: GBNP.PrintNPM#/
s/#GBNP.PrintNPM uses:[^#]*#/#GBNP.PrintNPM uses: GBNP.NPM2NPArray GBNP.PrintNPnonewline#/
s/#GBNP.PrintNPM is used in:[^#]*#/#GBNP.PrintNPM is used in: PrintNP#/
s/#GBNP.TransLetter uses:[^#]*#/#GBNP.TransLetter uses: GBNP.GetOptions#/
s/#GBNP.TransLetter is used in:[^#]*#/#GBNP.TransLetter is used in: GBNP.TransWord#/
s/#GBNP.TransWord uses:[^#]*#/#GBNP.TransWord uses: GBNP.TransLetter#/
s/#GBNP.TransWord is used in:[^#]*#/#GBNP.TransWord is used in: GBNP.PrintNPnonewline PrintNP wordfun#/
s/#GBNP.PrintTraceTerm uses:[^#]*#/#GBNP.PrintTraceTerm uses: GBNP.GetOptions#/
s/#GBNP.PrintTraceTerm is used in:[^#]*#/#GBNP.PrintTraceTerm is used in: GBNP.PrintTracePolCancel PrintTracePol#/
s/#wordfun uses:[^#]*#/#wordfun uses: GBNP.PrintTracePolCancel GBNP.TransWord NP2GP times wordfun#/
s/#wordfun is used in:[^#]*#/#wordfun is used in: wordfun#/
s/#times uses:[^#]*#/#times uses:#/
s/#times is used in:[^#]*#/#times is used in: wordfun#/
s/#wordfun uses:[^#]*#/#wordfun uses: GBNP.PrintTracePolCancel GBNP.TransWord NP2GP times wordfun#/
s/#wordfun is used in:[^#]*#/#wordfun is used in: wordfun#/
s/#GBNP.PrintTracePolCancel uses:[^#]*#/#GBNP.PrintTracePolCancel uses: GBNP.PrintTraceTerm#/
s/#GBNP.PrintTracePolCancel is used in:[^#]*#/#GBNP.PrintTracePolCancel is used in: wordfun#/
s/#PrintTracePol uses:[^#]*#/#PrintTracePol uses: GBNP.PrintTraceTerm#/
s/#PrintTracePol is used in:[^#]*#/#PrintTracePol is used in: PrintTraceList#/
s/#PrintTraceList uses:[^#]*#/#PrintTraceList uses: PrintTracePol#/
s/#PrintTraceList is used in:[^#]*#/#PrintTraceList is used in:#/
s/#PrintNPListTrace uses:[^#]*#/#PrintNPListTrace uses: PrintNPList#/
s/#PrintNPListTrace is used in:[^#]*#/#PrintNPListTrace is used in:#/
s/#EvalTrace uses:[^#]*#/#EvalTrace uses: AddNP BimulNP CleanNP#/
s/#EvalTrace is used in:[^#]*#/#EvalTrace is used in:#/
s/#GBNP.SortTP uses:[^#]*#/#GBNP.SortTP uses:#/
s/#GBNP.SortTP is used in:[^#]*#/#GBNP.SortTP is used in: GBNP.SortTPList#/
s/#GBNP.SortTPList uses:[^#]*#/#GBNP.SortTPList uses: GBNP.SortTP#/
s/#GBNP.SortTPList is used in:[^#]*#/#GBNP.SortTPList is used in: SGrobnerTrace#/
s/#GBNP.SpolyTrace uses:[^#]*#/#GBNP.SpolyTrace uses: AddNP BimulNP GBNP.AddTrace#/
s/#GBNP.SpolyTrace is used in:[^#]*#/#GBNP.SpolyTrace is used in: GBNP.CentralTrace GBNP.ObsTrace#/
s/#GBNP.StrongNormalFormTrace2 uses:[^#]*#/#GBNP.StrongNormalFormTrace2 uses: AddNP BimulNP GBNP.AddTrace GBNP.LTermsTrace GBNP.OccurInLst GBNP.ReduceCancellationTrace#/
s/#GBNP.StrongNormalFormTrace2 is used in:[^#]*#/#GBNP.StrongNormalFormTrace2 is used in: GBNP.CentralTrace GBNP.ObsTrace GBNP.ReducePolTailsTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop StrongNormalFormTraceDiff#/
s/#StrongNormalFormTraceDiff uses:[^#]*#/#StrongNormalFormTraceDiff uses: AddNP GBNP.StrongNormalFormTrace2#/
s/#StrongNormalFormTraceDiff is used in:[^#]*#/#StrongNormalFormTraceDiff is used in:#/
s/#GBNP.ObsTrace uses:[^#]*#/#GBNP.ObsTrace uses: GBNP.LTermsTrace GBNP.LeftObs GBNP.MkMonicNPTrace GBNP.RightObs GBNP.SelfObs GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#/
s/#GBNP.ObsTrace is used in:[^#]*#/#GBNP.ObsTrace is used in: GBNP.AllObsTrace GBNP.SGrobnerTraceLoop#/
s/#GBNP.CentralTrace uses:[^#]*#/#GBNP.CentralTrace uses: GBNP.LTermsTrace GBNP.MkMonicNPTrace GBNP.Occur GBNP.SpolyTrace GBNP.StrongNormalFormTrace2#/
s/#GBNP.CentralTrace is used in:[^#]*#/#GBNP.CentralTrace is used in: GBNP.SGrobnerTraceLoop#/
s/#GBNP.ReducePolTrace2 uses:[^#]*#/#GBNP.ReducePolTrace2 uses: GBNP.LTermsTrace GBNP.MkMonicNPTrace GBNP.Occur GBNP.StrongNormalFormTrace2 LtNP#/
s/#GBNP.ReducePolTrace2 is used in:[^#]*#/#GBNP.ReducePolTrace2 is used in: GBNP.AllObsTrace GBNP.ReducePolTrace SGrobnerTrace#/
s/#GBNP.ReducePolTrace uses:[^#]*#/#GBNP.ReducePolTrace uses: CleanNP GBNP.MkMonicNPTrace GBNP.ReducePolTrace2 GBNP.Traced#/
s/#GBNP.ReducePolTrace is used in:[^#]*#/#GBNP.ReducePolTrace is used in: SGrobnerTrace#/
s/#GBNP.ReducePolTailsTrace uses:[^#]*#/#GBNP.ReducePolTailsTrace uses: GBNP.StrongNormalFormTrace2#/
s/#GBNP.ReducePolTailsTrace is used in:[^#]*#/#GBNP.ReducePolTailsTrace is used in: SGrobnerTrace#/
s/#GBNP.AllObsTrace uses:[^#]*#/#GBNP.AllObsTrace uses: GBNP.LTermsTrace GBNP.ObsTrace GBNP.ReducePolTrace2#/
s/#GBNP.AllObsTrace is used in:[^#]*#/#GBNP.AllObsTrace is used in: SGrobnerTrace#/
s/#SGrobnerTrace uses:[^#]*#/#SGrobnerTrace uses: GBNP.AllObsTrace GBNP.ReducePolTailsTrace GBNP.ReducePolTrace GBNP.ReducePolTrace2 GBNP.SGrobnerTraceLoop GBNP.SortTPList#/
s/#SGrobnerTrace is used in:[^#]*#/#SGrobnerTrace is used in:#/
s/#GBNP.ReduceCancellationTrace uses:[^#]*#/#GBNP.ReduceCancellationTrace uses: GBNP.GetOptions#/
s/#GBNP.ReduceCancellationTrace is used in:[^#]*#/#GBNP.ReduceCancellationTrace is used in: GBNP.StrongNormalFormTrace2#/
s/#GBNP.IsFullTree uses:[^#]*#/#GBNP.IsFullTree uses:#/
s/#GBNP.IsFullTree is used in:[^#]*#/#GBNP.IsFullTree is used in: GBNP.RedAddToTree#/
s/#GBNP.RedAddToTree uses:[^#]*#/#GBNP.RedAddToTree uses: GBNP.CreateOccurTreeLR GBNP.IsFullTree GBNP.RedAddToTree#/
s/#GBNP.RedAddToTree is used in:[^#]*#/#GBNP.RedAddToTree is used in: GBNP.IncrT GBNP.RedAddListToTree GBNP.RedAddToTree PreprocessAnalysisQA#/
s/#GBNP.RedAddListToTree uses:[^#]*#/#GBNP.RedAddListToTree uses: GBNP.RedAddToTree#/
s/#GBNP.RedAddListToTree is used in:[^#]*#/#GBNP.RedAddListToTree is used in:#/
s/#GBNP.SuffixOfTree uses:[^#]*#/#GBNP.SuffixOfTree uses:#/
s/#GBNP.SuffixOfTree is used in:[^#]*#/#GBNP.SuffixOfTree is used in: GraphOfNormalWords#/
s/#GBNP.TreeToList uses:[^#]*#/#GBNP.TreeToList uses: GBNP.TreeToList#/
s/#GBNP.TreeToList is used in:[^#]*#/#GBNP.TreeToList is used in: GBNP.TreeToList PreprocessAnalysisQA#/
s/#GBNP.WeightedDegreeMon uses:[^#]*#/#GBNP.WeightedDegreeMon uses:#/
s/#GBNP.WeightedDegreeMon is used in:[^#]*#/#GBNP.WeightedDegreeMon is used in: GBNP.NewLevel GBNP.ObsTall GBNP.ObsTrunc GBNP.WeightedDegreeList#/
s/#GBNP.WeightedDegreeList uses:[^#]*#/#GBNP.WeightedDegreeList uses: GBNP.WeightedDegreeMon#/
s/#GBNP.WeightedDegreeList is used in:[^#]*#/#GBNP.WeightedDegreeList is used in: GBNP.CheckHom#/
s/#GBNP.NondivMonsByLevel uses:[^#]*#/#GBNP.NondivMonsByLevel uses: GBNP.OccurInLst#/
s/#GBNP.NondivMonsByLevel is used in:[^#]*#/#GBNP.NondivMonsByLevel is used in: GBNP.SGrobnerTrunc#/
s/#GBNP.ObsTrunc uses:[^#]*#/#GBNP.ObsTrunc uses: GBNP.LeftObs GBNP.RightObs GBNP.SelfObs GBNP.Spoly GBNP.StrongNormalForm2 GBNP.WeightedDegreeMon LMonsNP MkMonicNP#/
s/#GBNP.ObsTrunc is used in:[^#]*#/#GBNP.ObsTrunc is used in: GBNP.AllObsTrunc#/
s/#GBNP.AllObsTrunc uses:[^#]*#/#GBNP.AllObsTrunc uses: GBNP.ObsTrunc GBNP.ReducePol2 LMonsNP#/
s/#GBNP.AllObsTrunc is used in:[^#]*#/#GBNP.AllObsTrunc is used in: GBNP.SGrobnerTruncLevel#/
s/#GBNP.SGrobnerTruncLevel uses:[^#]*#/#GBNP.SGrobnerTruncLevel uses: GBNP.AllObsTrunc GBNP.ReducePol GBNP.ReducePol2 GBNP.SGrobnerTruncLoop#/
s/#GBNP.SGrobnerTruncLevel is used in:[^#]*#/#GBNP.SGrobnerTruncLevel is used in: GBNP.SGrobnerTrunc#/
s/#GBNP.NewLevel uses:[^#]*#/#GBNP.NewLevel uses: GBNP.WeightedDegreeMon#/
s/#GBNP.NewLevel is used in:[^#]*#/#GBNP.NewLevel is used in: GBNP.SGrobnerTrunc#/
s/#GBNP.CheckHom uses:[^#]*#/#GBNP.CheckHom uses: GBNP.WeightedDegreeList LMonsNP#/
s/#GBNP.CheckHom is used in:[^#]*#/#GBNP.CheckHom is used in: CheckHomogeneousNPs GBNP.SGrobnerTrunc#/
s/#CheckHomogeneousNPs uses:[^#]*#/#CheckHomogeneousNPs uses: CleanNP GBNP.CheckHom#/
s/#CheckHomogeneousNPs is used in:[^#]*#/#CheckHomogeneousNPs is used in:#/
s/#GBNP.SGrobnerTrunc uses:[^#]*#/#GBNP.SGrobnerTrunc uses: GBNP.CheckHom GBNP.NewLevel GBNP.NondivMonsByLevel GBNP.ReducePol GBNP.SGrobnerTruncLevel LMonsNP#/
s/#GBNP.SGrobnerTrunc is used in:[^#]*#/#GBNP.SGrobnerTrunc is used in: BaseQATrunc DimsQATrunc FreqsQATrunc SGrobnerTrunc#/
s/#GBNP.MakeArgumentLevel uses:[^#]*#/#GBNP.MakeArgumentLevel uses: GBNP.OccurInLst#/
s/#GBNP.MakeArgumentLevel is used in:[^#]*#/#GBNP.MakeArgumentLevel is used in: FreqsQATrunc#/
s/#SGrobnerTrunc uses:[^#]*#/#SGrobnerTrunc uses: GBNP.SGrobnerTrunc#/
s/#SGrobnerTrunc is used in:[^#]*#/#SGrobnerTrunc is used in:#/
s/#BaseQATrunc uses:[^#]*#/#BaseQATrunc uses: GBNP.SGrobnerTrunc#/
s/#BaseQATrunc is used in:[^#]*#/#BaseQATrunc is used in:#/
s/#DimsQATrunc uses:[^#]*#/#DimsQATrunc uses: GBNP.SGrobnerTrunc#/
s/#DimsQATrunc is used in:[^#]*#/#DimsQATrunc is used in:#/
s/#FreqsQATrunc uses:[^#]*#/#FreqsQATrunc uses: GBNP.MakeArgumentLevel GBNP.SGrobnerTrunc#/
s/#FreqsQATrunc is used in:[^#]*#/#FreqsQATrunc is used in:#/
