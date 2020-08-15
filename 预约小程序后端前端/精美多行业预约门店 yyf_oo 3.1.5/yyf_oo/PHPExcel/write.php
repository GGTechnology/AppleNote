<?php
	require_once './PHPExcel.php';
	// Create new PHPExcel object
	$objPHPExcel = new PHPExcel();

	// Set document properties
	$objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
							 ->setLastModifiedBy("Maarten Balliauw")
							 ->setTitle("Office 2007 XLSX Test Document")
							 ->setSubject("Office 2007 XLSX Test Document")
							 ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
							 ->setKeywords("office 2007 openxml php")
							 ->setCategory("Test result file");


	// Add some data
	$objPHPExcel->setActiveSheetIndex(0);
	$objPHPExcel->getActiveSheet()->setCellValue('A1', 'Firstname:')
											->setCellValue('A2', 'Lastname:')
											->setCellValue('A3', 'Fullname:')
											->setCellValue('B1', 'Maarten')
											->setCellValue('B2', 'Balliauw')
											->setCellValue('B3', '=B1 & " " & B2');

	// Define named ranges
	$objPHPExcel->addNamedRange( new PHPExcel_NamedRange('PersonName', $objPHPExcel->getActiveSheet(), 'B1') );
	$objPHPExcel->addNamedRange( new PHPExcel_NamedRange('PersonLN', $objPHPExcel->getActiveSheet(), 'B2') );

	// Rename named ranges
	$objPHPExcel->getNamedRange('PersonName')->setName('PersonFN');

	// Rename worksheet
	$objPHPExcel->getActiveSheet()->setTitle('Person');


	// Create a new worksheet, after the default sheet
	$objPHPExcel->createSheet();

	// Add some data to the second sheet, resembling some different data types
	$objPHPExcel->setActiveSheetIndex(1);
	$objPHPExcel->getActiveSheet()->setCellValue('A1', 'Firstname:')
											->setCellValue('A2', 'Lastname:')
											->setCellValue('A3', 'Fullname:')
											->setCellValue('B1', '=PersonFN')
											->setCellValue('B2', '=PersonLN')
											->setCellValue('B3', '=PersonFN & " " & PersonLN');

	// Rename worksheet
	$objPHPExcel->getActiveSheet()->setTitle('Person (cloned)');

	// Set active sheet index to the first sheet, so Excel opens this as the first sheet
	$objPHPExcel->setActiveSheetIndex(0);

	//直接保存文件
	// Save Excel 2007 file
	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save(str_replace('.php', '.xlsx', __FILE__));

	/*
	//导出另存为-Excel2007
	// Redirect output to a client’s web browser (Excel2007)

	header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
	header('Content-Disposition: attachment;filename="test.xlsx"');
	header('Cache-Control: max-age=0');

	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
	$objWriter->save('php://output');
	*/
	//导出另存为-Excel5
	// Redirect output to a client’s web browser (Excel5)
	header('Content-Type: application/vnd.ms-excel');
	header('Content-Disposition: attachment;filename="test.xls"');
	header('Cache-Control: max-age=0');

	$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
	$objWriter->save('php://output');