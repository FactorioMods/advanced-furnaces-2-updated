function unlockRecipe(event)
    for i, force in pairs(game.forces) do
        for _, tech in pairs(force.technologies) do
            if tech.researched then
                for _, effect in pairs(tech.prototype.effects) do
                    if effect.type == "unlock-recipe" then
                        force.recipes[effect.recipe].enabled = true
                    end
                end
            end
        end
            storage.wagons = {}
            storage.loader_wagon_map = {}
    end
end

unlockRecipe()
