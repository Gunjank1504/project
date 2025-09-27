namespace GeneratedProject.GeneratedProject;

using Microsoft.Inventory.Item;

pageextension 50001 Itemvarient_ext extends "Item Variants"
{
    layout
    {
        addafter(Description)
        {
            field(weight;Rec.weight)
            {
                Editable=true;
                ApplicationArea = All;
            }
        }
    }
}
