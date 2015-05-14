mapFileNames[source_, filenames_, target_] := 
 Module[{depth = FileNameDepth1}, 
  FileNameJoin[{target, FileNameDrop[#, depth]}] & /@ filenames]
 
htmlTreeToPlainText[source_, target_] := 
 Module[{htmlFiles, textFiles, targetDirs}, 
  htmlFiles = FileNames["*.html", source, Infinity]; 
  textFiles = 
   StringReplace[mapFileNames1, 
    f__ ~~ ".html" ~~ EndOfString :> f ~~ ".txt"]; 
  targetDirs = DeleteDuplicates[FileNameDrop[#, -1] & /@ textFiles]; 
  If[FileExistsQ[target], 
   DeleteDirectory[target, DeleteContents -> True]]; 
  Scan[CreateDirectory[#, CreateIntermediateDirectories -> True] &, 
   targetDirs]; 
  Scan[Export[#[[2]], Import[#[[1]], "Plaintext"], "Text"] &, 
   Transpose[{htmlFiles, textFiles}]]]
