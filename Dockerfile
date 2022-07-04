# FROM bitwalker/alpine-elixir-phoenix:latest

# # Cache elixir deps
# ADD mix.exs mix.lock ./
# RUN mix do deps.get, deps.compile

# EXPOSE 4000

# CMD elixir --sname $SNAME --cookie cookie -S mix phx.server

FROM bitwalker/alpine-elixir-phoenix:latest

# Set exposed ports
EXPOSE 4000
# ENV PORT=5000 MIX_ENV=prod

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Same with npm deps
# ADD assets/package.json assets/
# RUN cd assets && \
#     npm install

ADD . .

# Run frontend build, compile, and digest assets
# RUN cd assets/ && \
#     npm run deploy && \
#     cd - && \
#     mix do compile, phx.digest

RUN mix compile

# USER default

# CMD ["mix", "phx.server"]
CMD elixir --sname $SNAME --cookie cookie -S mix phx.server