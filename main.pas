unit main;

interface

procedure run;

implementation

uses
  Allegro5;

const
  DISPLAY_WIDTH  = 800;
  DISPLAY_HEIGHT = 600;

var
  Display: ALLEGRO_DISPLAYptr;
  EventQueue: ALLEGRO_EVENT_QUEUEptr;

procedure init;
begin
  WriteLn('init');

  if not al_init then
  begin
    WriteLn('init error');
    halt(1);
  end;

  if not al_install_keyboard then
  begin
    WriteLn('install keyboard error');
    halt(1);
  end;

  Display := al_create_display(DISPLAY_WIDTH, DISPLAY_HEIGHT);
  if Display = nil then
  begin
    WriteLn('create display error');
    halt(1);
  end;

  al_set_window_title(Display, 'allegro-pas5 test1');

  EventQueue := al_create_event_queue();
  if EventQueue = nil then
  begin
    writeln('create event queue error');
    halt(1);
  end;

  al_register_event_source(EventQueue, al_get_keyboard_event_source);
  al_register_event_source(EventQueue, al_get_display_event_source(display));
end;

procedure cleanup;
begin
  WriteLn('cleanup');

  al_destroy_event_queue(EventQueue);
  al_destroy_display(Display);
  al_uninstall_keyboard;
end;

procedure gameLoop;
var
  Running: Boolean;
  Event: ALLEGRO_EVENT;
begin
  WriteLn('run');

  Running := true;

  while Running do
  begin
    if al_get_next_event(eventQueue, event) then
    begin
      case event._type of
        ALLEGRO_EVENT_DISPLAY_CLOSE:
          running := false;
        ALLEGRO_EVENT_KEY_DOWN:
          if (event.keyboard.keycode = ALLEGRO_KEY_ESCAPE) then
            running := false;
      end;
    end else
    begin
      al_clear_to_color(al_map_rgb(0, 0, 0));
      al_flip_display();
    end;
  end;
end;

procedure run;
begin
  WriteLn('start');

  init;
  gameLoop;
  cleanup;

  WriteLn('end');
end;

end.
