



import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
public int numBombs = 35;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    // initialize buttons
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r, c);
        }

for(int i = 0; i <numBombs; i++) 
    setBombs();
}
public void setBombs()
{
   // while(bombs.size() < 35){
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        //System.out.println(bombs.contains(buttons[r][c]));
        if(!bombs.contains(buttons[r][c]));
        {
            bombs.add(buttons[r][c]);
            System.out.println(r + ", " + c);
        }
//}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int i = 0; i < NUM_ROWS; i++) 
        for(int m = 0; m < NUM_COLS; m++)
                 if(!buttons[i][m].isMarked()&&!buttons[i][m].isClicked())
                      return false;
    return true;
}
public void displayLosingMessage()
{
    //your code here
        buttons[9][6].setLabel("Y");
        buttons[9][7].setLabel("O");
        buttons[9][8].setLabel("U");
        buttons[9][9].setLabel(" ");
        buttons[9][10].setLabel("L");
        buttons[9][11].setLabel("O");
        buttons[9][12].setLabel("S");
        buttons[9][13].setLabel("E");

}
public void displayWinningMessage()
{
     
    //your code here
        fill(0,0,0);
        buttons[10][6].setLabel("W");
        buttons[10][7].setLabel("I");
        buttons[10][8].setLabel("N");
        buttons[10][9].setLabel("N");
        buttons[10][10].setLabel("E");
        buttons[10][11].setLabel("R");
        buttons[10][12].setLabel("!");


}



public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT) {//&& clicked == false)
            marked = !marked;
            if(marked == false)
                clicked = false;
}
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c) > 0){
            label = ""+countBombs(r,c);
        }
        else{
            for(int row = r  - 1 ; row < r+2; row++)
                for(int col = c - 1; col < c+2; col++){
                    if(isValid(row, col) == true && buttons[row][col].isClicked() == false)
                        buttons[row][col].mousePressed();
                }
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0)
            return true;
//else
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int r = row - 1; r <= row + 2; r++)
            for(int c = col - 1; c <= col + 2; c++)//{
                if(isValid(r,c) == true && bombs.contains(buttons[r][c]))
                    numBombs++;
           /* }
            if(bombs.contains(buttons[r][c])){
                numBombs--;
            }*/
            return numBombs;
    }
}







