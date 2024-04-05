function dataset = RegDatasetLoader(dataset_name)

if(strcmp(dataset_name,'rebar'))
    dataset.input = load('dataSets\input_rebar_dataset.txt')';
    dataset.output = load('dataSets\output_rebar_dataset.txt')';
    % INPUT
    % Column 1: Transversal section (mm2)
    % Column 2: Carbon
    % Column 3: Chromium
    % Column 4: Copper
    % Column 5: Manganese
    % Column 6: Molybdenum
    % Column 7: Niobium
    % Column 8: Nickel
    % Column 9: Phosphorus
    % Column 10: Sulfur
    % Column 11: Silicon
    % Column 12: Tin
    % Column 13: Vanadium
    % Column 14: Finishing rolling temperature
    % Column 15: Initial heat treatment temperature
    % Column 16: Final heat treatment temperature
    % Column 17: Pressure of the heat treatment water 
    % Column 18: Flow of the heat treatment water
    % 
    % OUTPUT
    % Column 1: Yield Strengh (YS)
    % Column 2: Ultimate Tensile Strengh (UTS)
    % Column 3: UTS/YS ratio
    % Column 4: Elongation (PE)

elseif(strcmp(dataset_name,'none'))

end

end