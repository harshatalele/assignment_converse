import openpyxl


def get_template_names_from_excel(file_path, sheet_name):
    """
    Reads the Excel file and extracts template names from the specified sheet.

    Args:
        file_path (str): The full path to the Excel file.
        sheet_name (str): The name of the sheet to read from.

    Returns:
        list: A list of template names found in the first column (excluding header).
    """
    # Load the workbook from the given file path
    wb = openpyxl.load_workbook(file_path)

    # Select the sheet by its name
    sheet = wb[sheet_name]

    template_names = []

    # Iterate over rows starting from second row (min_row=2) to skip header
    # values_only=True means each row is a tuple of cell values, not cell objects
    for row in sheet.iter_rows(min_row=2, values_only=True):
        # Check if first cell in the row is not None (non-empty)
        if row[0]:
            template_names.append(row[0])

    return template_names
