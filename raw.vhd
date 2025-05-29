library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity menu_controller is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        btn_left    : in  STD_LOGIC;
        btn_right   : in  STD_LOGIC;
        seg_left    : out STD_LOGIC_VECTOR(6 downto 0);
        seg_right   : out STD_LOGIC_VECTOR(6 downto 0)
    );
end menu_controller;

architecture Behavioral of menu_controller is
    signal count        : INTEGER range 0 to 9 := 0;
    signal selected     : INTEGER range 0 to 9 := 0;
    signal btn_l_prev   : STD_LOGIC := '0';
    signal btn_r_prev   : STD_LOGIC := '0';

    function to_seven_segment(val : INTEGER) return STD_LOGIC_VECTOR is
        variable seg : STD_LOGIC_VECTOR(6 downto 0);
    begin
        case val is
            when 0 => seg := "0000000";
            when 1 => seg := "0000001";
            when 2 => seg := "0000010";
            when 3 => seg := "0000011";
            when 4 => seg := "0000100";
            when 5 => seg := "0000101";
            when 6 => seg := "0000110";
            when 7 => seg := "0000111";
            when 8 => seg := "0001000";
            when 9 => seg := "0001001";
            when others => seg := "1111111";
        end case;
        return seg;
    end function;

begin
    process(clk, rst)
    begin
        if rst = '1' then
            count    <= 0;
            selected <= 0;
            btn_l_prev <= '0';
            btn_r_prev <= '0';
        elsif rising_edge(clk) then
            -- detekcja zbocza narastaj¹cego
            if btn_left = '1' and btn_l_prev = '0' then
                count <= (count + 1) mod 10;
            end if;

            if btn_right = '1' and btn_r_prev = '0' then
                selected <= count;
            end if;

            btn_l_prev <= btn_left;
            btn_r_prev <= btn_right;
        end if;
    end process;

    seg_left  <= to_seven_segment(count);
    seg_right <= to_seven_segment(selected);
end Behavioral;
