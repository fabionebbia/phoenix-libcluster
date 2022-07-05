FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
EXPOSE 4000

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

RUN mix compile

CMD elixir --sname $SNAME --cookie cookie -S mix phx.server